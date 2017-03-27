<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Assignment marking assistant</title>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/tachyons/4.6.2/tachyons.min.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.6.1/clipboard.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.4/lodash.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js" type="text/javascript"></script>

<script type="text/javascript" id="grading-data">
    /**
     * Grading data
     * loaded from URL supplied by the user
     */
    var gradingData = null;
    $(document).ready(function() {
        $.getJSON("/gradings/{{assignment}}.json").done(function(json) {
            console.log(json);
            gradingData = json;
            renderGradingSheet();
        }).fail(function(jqxhr, status, error) {
            console.log(status, error);
        });
        $('#calculate').click(function() {
            calculate_grades();
        });
    });
</script>

<script type="text/javascript" id="grading-sheet">
    var renderGradingSheet = function() {
        var container = $('#gradingSheet');
        // set title and total marks
        $('#assignment-properties').append([
            "<p>" 
            + gradingData.assignment_title 
            + " (" + gradingData.assignment_marks + " marks)"
            + "</p>"
        ].join("\n"));
        // create sections
        // each section is a tile
        _.forEach(gradingData.sections, function(section) {
            var divSection = $('<div>', {class: 'w-20 fl db ba ph2 ma2'});
            divSection.append("<p class='tc f5'><b>" + section.title + "</b></p>");
            _.forEach(section.gradings, function(gradeSection) {
                var divGradeSection = gradeTypeHandlers[gradeSection.type](gradeSection);
                divSection.append(divGradeSection);
            });
            container.append(divSection);
        });
    };

    /**
     * grade Type Handlers
     * creates and returns grade subsection according to specified type
     * @type {Object}
     */
    var gradeTypeHandlers = {
        "negative-collective": function(gradeSection) {
            /**
             * NEGATIVE COLLECTIVE
             * Represents collection of negative responses
             * Has only one correct response if any of them are correct
             */
            var div = $('<div>', {class: 'pv2'});
            div.append("<p><b>" + gradeSection.description + "</b></p>");
            _.each(gradeSection.collection, function(comment) {
                var label = $('<label>', {class: "db dark-red"});
                var input = $('<input>', {type: "checkbox", class: "mr1"});
                label.append(input);
                label.append(comment[0]);
                div.append(label);
                comment.input = input;
            });
            return div;
        },
        "negative": function(gradeSection) {
            /**
             * NEGATIVE COMMENT
             * Deducts marks if ticked
             */
            var div = $('<div>', {class: 'pv2'});
            div.append("<p><b>" + gradeSection.description + "</b></p>");
            _.each(gradeSection.collection, function(comment) {
                var label = $('<label>', {class: "db dark-red"});
                var input = $('<input>', {type: "checkbox", class: "mr1"});
                label.append(input);
                label.append(comment[1]);
                comment.input = input;
                div.append(label);
            });
            return div; 
        },
        "positive-optional": function(gradeSection) {
        	/**
        	 * POSITIVE OPTIONAL
        	 * A positive comment that earns extra marks if correct
        	 * Does nothing if wrong
        	 */
        	var div = $('<div>', {class: 'pv2'});
            var label = $('<label>', {class: "db dark-green"});
            var input = $('<input>', {type: "checkbox", class: "mr1"});
            label.append(input);
            label.append("(+ve) " + gradeSection.description);
            div.append(label);
            return div; 
        },
        "positive-optional-collective": function(gradeSection) {
        	/**
        	 * POSITIVE OPTIONAL COLLECTIVE
        	 * Positive comments that earns extra marks if correct
        	 * Does nothing if wrong
        	 */
        	var div = $('<div>', {class: 'pv2'});
            div.append("<p><b>" + gradeSection.description + "</b></p>");
            _.each(gradeSection.collection, function(comment) {
    	        var label = $('<label>', {class: "db dark-green"});
    	        var input = $('<input>', {type: "checkbox", class: "mr1 green"});
    	        label.append(input);
    	        label.append("(+ve) " + comment);
    	        div.append(label);
    	    });
            return div; 
        },
        "positive-collective": function(gradeSection) {
        	/**
        	 * POSITIVE OPTIONAL COLLECTIVE
        	 * Positive comments that earns extra marks if correct
        	 * Does nothing if wrong
        	 */
        	var div = $('<div>', {class: 'pv2'});
            div.append("<p><b>" + gradeSection.description + "</b></p>");
            _.each(gradeSection.collection, function(comment) {
    	        var label = $('<label>', {class: "db dark-green"});
    	        var input = $('<input>', {type: "checkbox", class: "mr1 green"});
    	        label.append(input);
    	        label.append("(+ve) " + comment);
    	        div.append(label);
    	    });
            return div; 
        }
    };
</script>

<script type="text/javascript" id="grade-marker">
var total_marks = 0;
var copy_counter = 0;

var calculate_grades = function() {
    var message = "";
    _.each(gradingData.sections, function(section) {
        var section_marks = section.marks;
        var section_message_positive = "";
        var section_message_negative = "";
        _.each(section.gradings, function(grading) {
            if (grading.type == "negative-collective") {
                var ticked_items = 0;
                _.each(grading.collection, function(comment) {
                    if (comment.input.is(":checked")) {
                        ticked_items += 1;
                        section_message_negative += comment[0] + "<br>";
                    }
                });
                if (ticked_items == 0) {
                    // ALL POSITIVE -> NO ITEMS WERE TICKED
                    section_message_positive += grading.positive_comment + "<br>";
                } else {
                	if (ticked_items < grading.collection.length) {
                		// SOME ITEMS WERE TICKED
                		section_message_positive += grading.partial_comment + "<br>";
                	}
                }
                section_marks = section_marks - grading.marks * ticked_items;
            } else if (grading.type == "negative") {
            	_.each(grading.collection, function(comment) {
            		if (comment.input.is(":checked")) {
            			section_marks -= comment[0];
            			section_message_negative += comment[1] + "<br>";
            		} else {
            			section_message_positive += comment[2] + "<br>";
            		}
            	});
            }
            message = [
	            message,
	            "<b>" + section.title,
	            "Marks: " + section_marks + " from " + section.marks + "</b>",
	            "<div class='dark-green'>" + section_message_positive + "</div><div class='dark-red'>" + section_message_negative + "</div>",
	            "<br>"
	        ].join("<br>");
        });
        total_marks += section_marks;
    });
    $('#message').empty();
    $('#message').append("Total marks: " + total_marks + "<br>");
    $('#message').append(message);
};

var copy_message = function(e) {
	copy_counter += 1;
	if (copy_counter == 1) {
		swal({
			"title": "Put down marks as <b>" + total_marks + "</b>",
			"type": "success",
			"html": true
		});
	} else {
		swal({
			"title": "Put down marks as <b>" + total_marks + "</b>",
			"text": "<br>WARNING: COPIED MORE THAN ONCE WITHOUT CLEARING",
			"type": "warning",
			"html": true
		});
	}
    e.clearSelection();
    total_marks = 0;
}

var clear_board = function() {
	total_marks = 0;
	$("input:checkbox").prop("checked", false);
	$('#message').empty();
	copy_counter = 0;
}
</script>

<script type="text/javascript" id="clipboard">
    /**
     * Uses clipboard.js to copy feedback response to clipboard
     * Shows alert for success, alert.
     * Clears selection so copyied text is not highlighted
     */
    $(document).on('ready', function() {
	    var clipboard = new Clipboard('#calculate');
	    clipboard.on('success', copy_message);
	    clipboard.on('error', function(e) {
	        alert('ERROR: TEXT NOT COPIED TO CLIPBOARD');
	    });
	});
</script>

</head>
<body class="bg-washed-blue">
<div class='w-100 ph5 center pb1'>
    <div id="assignment-properties" class="f2 blue tc"></div>
	<!-- <div id="dataURL" class="dn">
        <div class="w-80-ns center pa2">
            <button id="btn-load-dataURL" class="pl2 dark-green">Load grading data</button><input id="input-dataURL" class="w-80 pl2" type="url">
        </div>   
    </div> -->
    <div id="gradingSheet" class="pv1 center fl w-100">

    </div>
	<div id="gradeCalculator" class="">
        <div class="w-25 center" style="position:fixed; top:10px; right: 10px;">
        	<button id="calculate" data-clipboard-target="#message" class="bg-dark-green gold pv2 mb2">Calculate & Copy</button>
        	<button id="clear" onclick="clear_board();" class="bg-washed-red pv2 mb2">Clear</button>
        </div>
        <div id="message" class="w-80 center db pa2 mt2"></div>
	</div>
</div>
<footer class="pv4 ph3 ph5-m ph6-l mid-gray tc">
	<div class="w-80 fl center near-black pv3 pb3 mt3">
		Script by <a href="https://harshp.com" rel="author">Harsh</a>
	</div>
</footer>
</body>
