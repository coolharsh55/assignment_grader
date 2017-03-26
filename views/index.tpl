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
    gradingData = {
        "assignment_title": "Harness",
        "assignment_marks": 100,
        "sections": [
            {
                "title": "Harness Class: Member variables",
                "marks": 8,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "marks": 0.5,
                        "description": "member variables",
                        "positive_comment": "Correctly declares member variables",
                        "partial_comment": "correctly declares only some member variables",
                        "collection": [
                            ["make is not of type string"],
                            ["model is not of type string/int"],
                            ["number of times used is not of type int"],
                            ["instructor name is not of type string"],
                            ["loan status is not of type boolean"],
                            ["club member is not of type string"],
                        ]
                    },
                    {
                        "type": "negative-collective",
                        "marks": 0.5,
                        "description": "member access control",
                        "positive_comment": "declares members as private",
                        "partial_comment": "declares only some members as private",
                        "collection": [
                            ["make is not declared as private"],
                            ["model is not declared as private"],
                            ["number of times is not declared as private"],
                            ["instructor name is not declared as private"],
                            ["loan status is not declared as private"],
                            ["club member is not declared as private"]
                        ]
                    },
                    {
                    	"type": "negative-collective",
                    	"marks": 0.5,
                    	"description": "members declared final",
                    	"positive_comment": "make and model declared as final",
                    	"partial_comment": "some members correctly declared as final",
                    	"collection": [
                    		["make not declared final"],
                    		["model not declared final"]
                    	]
                    },
                    {
                    	"type": "negative",
                    	"description": "constant declaring max number of uses",
                    	"collection": [
                            [1, "does not have constant declaring max number of uses for a harness", "has constant declaring max number of uses for a harness"]
                        ]
                    }
                ]
            },
            {
            	"title": "Harness Class: constructor 1",
            	"marks": 3,
            	"gradings": [
            		{
            			"type": "negative-collective",
            			"marks": 0.5,
            			"description": "initialise member variables from input",
            			"positive_comment": "initialises member variables from input",
            			"partial_comment": "initialises some member variables with correct values",
            			"collection": [
            				["make is not initialised from input"],
                            ["model is not initialised from input"],
                            ["number of times is not initialised from input"],
                            ["instructor name is not initialised from input"],
                            ["loan status is not initialised from input"],
                            ["club member is not initialised from input"],
            			]
            		}
            	]
            },
            {
            	"title": "Harness Class: constructor 2",
            	"marks": 3,
            	"gradings": [
            		{
            			"type": "negative-collective",
            			"marks": 0.5,
            			"description": "initialise some with others set to default",
            			"positive_comment": "correctly initialises some variables with others set to resonable defaults",
            			"partial_comment": " initialises some members with correct values",
            			"collection": [
            				["make is not initialised to given value"],
                            ["model is not initialised to given value"],
                            ["instructor name is not initialised to given value"],
                            ["number of times is not initialised to reasonable default"],
                            ["loan status is not initialised to reasonable default"],
                            ["club member is not initialised to reasonable default"],
            			]
            		}
            	]
            },
            {
            	"title": "Harness Class: checkHarness",
            	"marks": 5,
            	"gradings": [
            		{
            			"type": "negative-collective",
            			"marks": 0.5,
            			"description": "function definition",
            			"positive_comment": "takes instruction name as parameter and return type is void",
            			"partial_comment": "function definition is only partially correct",
            			"collection": [
            				["instructor name not taken as parameter"],
            				["return type should be void"]
            			]
            		},
            		{
            			"type": "negative",
                        "description": "action steps",
                        "collection": [
                            [1, "does not check if harness is not on loan", "checks if harness is on loan"],
                            [1, "does not check if parameter is not null", "checks if parameter is not null"],
                            [1, "does not set instructor member to given parameter", "sets instructor member to given parameter"],
                            [1, "does not reset the number of times the harness was used", "resets the number of times the harness was used"]
                        ]
            		}
            	]
            },
            {
                "title": "Harness Class: isHarnessOnLoad",
                "marks": 2,
                "gradings": [
                    {
                        "type": "negative",
                        "description": "function definition",
                        "collection": [
                            [0.5, "method should have no parameters", "method has no parameters"],
                            [0.5, "method should have boolean return type", "method has boolean return type"],
                            [1, "does not return value of loan status", "returns loan status"]
                        ]
                    }
                ]
            },
            {
                "title": "Harness Class: canHarnessBeLoaned",
                "marks": 4,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "marks": 0.5,
                        "description": "function definition",
                        "positive_comment": "has correct function definition",
                        "partial_comment": "has partially correct function definition",
                        "collection": [
                            ["method should not have any parameters"],
                            ["method should have boolean return type"]
                        ]
                    },
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [1, "method should return true if harness was not on loan", "method returns true if harness was on loan"],
                            [1, "should check if number of times it was used is less than maximum allowed value", "checks if number of times used is within maximum limit"],
                            [1, "return value should be based on number of times used", "return value is based on number of times used"]
                        ]
                    }
                ]
            },
            {
                "title": "Harness Class: loanHarness",
                "marks": 6,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "marks": 0.5,
                        "description": "function definition",
                        "positive_comment": "has correct function definition",
                        "partial_comment": "has partially correct function definition",
                        "collection": [
                            ["method should have member name as parameter"],
                            ["method should have void as return type"]
                        ]
                    },
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [1, "does not check if harness can be loaned using method", "checks if harness can be loaned using method"],
                            [1, "does not check if parameter is null", "checks if parameter is null"],
                            [1, "does not set club member to parameter", "sets club member to parameter"],
                            [1, "does not set on loan status to true", "sets on loan status to true"],
                            [1, "does not increment number of times used", "increments number of times used"]
                        ]
                    }
                ]
            },
            {
                "title": "Harness Class: returnHarness",
                "marks": 5,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "marks": 0.5,
                        "description": "function definition",
                        "positive_comment": "has correct function definition",
                        "partial_comment": "has partially correct function definition",
                        "collection": [
                            ["method should have no parameters"],
                            ["method should have void as return type"]
                        ]
                    },
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [1, "does not check if harness is on loan", "checks if harness is on loan"],
                            [1, "does not change loan status to false", "changes loan status to false"],
                            [1, "does not reset club member value to null", "resets club member value to null"],
                        ]
                    }
                ]
            },
            {
                "title": "Harness Class: toString",
                "marks": 3,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "marks": 0.5,
                        "description": "function definition",
                        "positive_comment": "has correct function definition",
                        "partial_comment": "has partially correct function definition",
                        "collection": [
                            ["method should have no parameter"],
                            ["method should have String as return type"]
                        ]
                    },
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [2, "should return string with details of all member variables", "returns string with details of member variables"]
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: member variables",
                "marks": 2,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "marks": 1,
                        "description": "member variables",
                        "positive_comment": "declares collection of Harnesses as private member variable",
                        "partial_comment": "does not correctly declare member variables",
                        "collection": [
                            ["should declare member variable as collection of Harnesses"],
                            ["should declare member variable as private"]
                        ]
                    }
                ] 
            },
            {
                "title": "HarnessRecords Class: constructor 1",
                "marks": 1,
                "gradings": [
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [1, "should set member variable to null", "sets member variable to null"]
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: constructor 2",
                "marks": 8,
                "gradings": [
                    {
                        "type": "negative",
                        "description": "constructor actions",
                        "collection": [
                            [1, "should takes a input stream as a parameter which this can be of several types: In, Scanner, etc.", "takes a input stream as a parameter which this can be of several types: In, Scanner, etc."],
                            [1, "should check if the stream is not null", "checks if the stream is not null"],
                            [1, "should read the first value which defines the size of the collection of harnesses", "reads the first value which defines the size of the collection of harnesses"],
                            [2, "should read other harness characteristics from the stream", "reads other harness characteristics from the stream"],
                            [2, "should initialise Harness using constructor by passing values read from the stream/text file", "initialises Harness using constructor by passing values read from the stream/text file"],
                            [1, "should add each Harness object to collection ", "should add each Harness object to collection"]
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: isEmpty",
                "marks": 3,
                "gradings": [
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [0.5, "should not have any parameters", "does not have any parameters"],
                            [0.5, "should have a boolean return type", "has a boolean return type"],
                            [0.5, "should return true if collection is null", "returns true if collection is null"],
                            [0.5, "should return false if collection is not null", "returns false if collection is not null"]                            
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: addHarness",
                "marks": 5,
                "gradings": [
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [0.5, "must take Harness object as parameter", "takes Harness object as parameter"],
                            [0.5, "should have void return type", "has void return type"],
                            [4, "should add harness to collection", "adds harness to collection"]
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: findHarness",
                "marks": 6,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "description": "function definition",
                        "marks": 0.5,
                        "positive_comment": "has correct definition",
                        "partial_comment": "has partially correct function definition",
                        "collection": [
                            ["should have make and model number as parameters"],
                            ["should return Harness object"],
                        ]
                    },
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [4, "should check if harness with properties exists by looping through collection", "checks if harness with properties exists in collection"],
                            [0.5, "should return harness object if it exists", "returns harness object if it exists"],
                            [0.5, "should return null if harness does not exist", "returns null if harness does not exist"]
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: checkHarness",
                "marks": 9,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "marks": 1,
                        "description":"function definition",
                        "positive_comment": "has correct parameters and return type",
                        "partial_comment": "has partially correct parameters and return type",
                        "collection": [
                            ["does not have instructor name as parameter"],
                            ["does not have make as parameter"],
                            ["does not have model number as parameter"],
                            ["does not have return type Harness"]
                        ]
                    },
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [2, "should check if harness with make and model number exists using findHarness", "uses findHarness to find harness with given make and model number"],
                            [1, "should check if harness is on loan", "checks if harness is on loan"],
                            [1, "should call checkHarness with instructor name", "calls checkHarness with instructor name"],
                            [0.5, "should use updated Harness object returned from checkHarness", "uses updated Harness object from checkHarness"],
                            [0.5, "should return null if harness is not available", "returns null if harness is not available"]
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: loanHarness",
                "marks": 7,
                "gradings": [
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [1, "must take a club member name as parameter", "takes club member name as parameter"],
                            [1, "must have return type Harness", "has return type Harness"],
                            [2, "should ind available harness by looping through collection", "finds available harness by looping through collection"],
                            [1, "should call canHarnessBeLoaned", "calls canHarnessBeLoaned"],
                            [1, "available harness should be loaned using loanHarness", "available harness is loaned using loanHarness"],
                            [1, "should pass club member as parameter to loanHarness", "passes club member as parameter to loanHarness"],
                            [0.5, "should return harness object", "returns harness object"],
                            [0.5, "should return null if harness not available", "returns null if harness not available"]
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: returnHarness",
                "marks": 7,
                "gradings": [
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [2, "must take make and model number as parameters", "takes make and model number as parameters"],
                            [1, "should return type Harness", "return type is Harness"],
                            [1, "should find harness using findHarness", "finds harness using findHarness"],
                            [1, "should check if found harness is null", "checks if found harness is null"],
                            [1, "should check if found harness is on loan", "checks if found harness is on loan"],
                            [0.5, "should return harness object using returnHarness", "uses returnHarness"],
                            [0.5, "should return null if no harness is found", "returns null if no harness is found"]
                        ]
                    }
                ]
            },
            {
                "title": "HarnessRecords Class: removeHarness",
                "marks": 8,
                "gradings": [
                    {
                        "type": "negative",
                        "description": "action steps",
                        "collection": [
                            [2, "must take make and model number as parmeters", "takes make and model number as parameters"],
                            [1, "should return type Harness", "return type is Harness"],
                            [2, "should check collection using specified properties", "checks collection using specified properties"],
                            [2, "should remove object (if using ArrayList) or replace array", "correctly replaces object (ArrayList) or array"],
                            [0.5, "shoud return harness object found", "returns harness object found"],
                            [0.5, "should return null if harness not found", "returns null if harness not found"]
                        ]
                    }
                ]
            },
            {
                "title": "GUI main line",
                "marks": 5,
                "gradings": [
                    {
                        "type": "negative-collective",
                        "marks": 1,
                        "description": "menu",
                        "positive_comment": "has correct menu options",
                        "partial_comment": "has only some menu options",
                        "collection": [
                            ["missing option add new harness to collection"],
                            ["missing option remove harness from collection"],
                            ["missing option check harness by instructor"],
                            ["missing option loan harness to club member"],
                            ["missing option return harness with make and model number"]
                        ]
                    }
                ]
            }
        ]
    }
    $(document).ready(function() {
        $('#btn-load-dataURL').click(function() {
            var input_dataURL = $('#input-dataURL').val();
            // $.getJSON(input_dataURL, function(json) {
            //     // gradingData = json;
            // });
            $('#dataURL').hide();
            renderGradingSheet();
        });
        $('#calculate').click(function() {
            calculate_grades();
        });
        renderGradingSheet();
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
    $('#message').append("Total marks: " + total_marks + " from 100" + "<br>");
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
