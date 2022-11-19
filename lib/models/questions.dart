var quizes = ["html", "css", "javascript", "phyton", "flutter"];

Map<String, dynamic> questions = {
  "html": [
    {
      "question": "What is the HTML element for the biggest heading?",
      "anwsers": ["H1", "H2", "Header", "Heading"],
      "correct": "H1"
    },
    {
      "question": "How to define a hyperlink in HTML?",
      "anwsers": ["<link>", "<l>", "<a>", "<url>"],
      "correct": "<a>"
    },
    {
      "question": "How to define a line break in HTML?",
      "anwsers": ["<break>", "<line>", "<br>", "<lb>"],
      "correct": "<br>"
    },
    {
      "question": "How to define a color for a div in HTML?",
      "anwsers": ["<div style='color:yellow'>", "<div color='yellow'>"],
      "correct": "<div style='color:yellow'>"
    },
    {
      "question": "HTML is a language used for?",
      "anwsers": [
        "Backend programming",
        "Defining styles",
        "Server integration",
        "Structuring websites"
      ],
      "correct": "Structuring websites"
    },
    {
      "question": "How to defined a text as bold in HTML?",
      "anwsers": ["<b>", "<bold>", "<i>"],
      "correct": "<bold>"
    },
    {
      "question": "Can you use image, videos etc in HTML?",
      "anwsers": ["Yes", "No"],
      "correct": "Yes"
    },
    {
      "question": "What language do you use to style HTML files?",
      "anwsers": ["SQL", "CSS", "JavaScript"],
      "correct": "CSS"
    },
    {
      "question": "Which of the following is a valid color code?",
      "anwsers": ["#010101", "*010101"],
      "correct": "#010101"
    },
    {
      "question": "HTML files run on a?",
      "anwsers": ["Browser", "Server", "Code processor", "Text editor"],
      "correct": "Browser"
    },
    {
      "question": "How to define a button?",
      "anwsers": ["<b>", "<btn>", "<button>"],
      "correct": "<button>"
    },
    {
      "question": "What language is used to bring functionalities to HTML?",
      "anwsers": ["JavaScript", "Phyton", "Java"],
      "correct": "JavaScript"
    },
    {
      "question": "When was HTML created?",
      "anwsers": ["1993", "1998", "2003", "2008"],
      "correct": "1993"
    },
    {
      "question": "How to define a paragraph in HTML?",
      "anwsers": ["<p>", "<paragraph>", "<pr>", "<text>"],
      "correct": "<p>"
    },
    {
      "question": "How to import CSS to a HTML file?",
      "anwsers": ["<css>", "<style>", "<link>"],
      "correct": "<link>"
    },
    {
      "question": "How to close a HTML tag?",
      "anwsers": ["</tag>", "<closetag>", "<endtag>"],
      "correct": "</tag>"
    },
    {
      "question": "How to define an ordened list?",
      "anwsers": ["<ul>", "<ol>", "<list>"],
      "correct": "<ol>"
    },
    {
      "question": "How to define an item in a list?",
      "anwsers": ["<item>", "<li>", "<il>"],
      "correct": "<li>"
    },
    {
      "question": "How to define an image in HTML?",
      "anwsers": ["<image>", "<photo>", "<img>"],
      "correct": "<img>"
    },
    {
      "question": "How to define a video in HTML?",
      "anwsers": ["<vid>", "<video>", "<v>"],
      "correct": "<video>"
    }
  ],
  "css": [
    {
      "question": "What's CSS used for?",
      "anwsers": ["Styling websites", "Functional Programming", "Data storaging", "Visual analysing"],
      "correct": "Styling websites"
    },
    {
      "question": "Which is the most recent CSS version?",
      "anwsers": ["CSS2", "CSS3", "CSS5"],
      "correct": "CSS3"
    },
    {
      "question": "Which property do we change to increase external spacing in an element?",
      "anwsers": ["external-space", "margin", "padding", "space"],
      "correct": "margin"
    },
    {
      "question": "Which one of these is a CSS Framework?",
      "anwsers": ["React", "Bootstrap", "Laravel"],
      "correct": "Bootstrap"
    },
    {
      "question": "How do we define styles for a class in CSS?",
      "anwsers": [".class", "#class", "*class"],
      "correct": ".class"
    },
    {
      "question": "How to change the size of an element in CSS?",
      "anwsers": ["Changing width and height properties", "Changing size and proportion properties"],
      "correct": "Changing width and height properties"
    },
    {
      "question": "When was CSS launched?",
      "anwsers": ["1991", "1996", "2001", "2006"],
      "correct": "1996"
    },
    {
      "question": "Which property do we use to change the background color?",
      "anwsers": ["color", "bg-color", "background-color"],
      "correct": "background-color"
    },
    {
      "question": "How do we define styles for an Id in CSS?",
      "anwsers": [".id", "#id", "*id"],
      "correct": "#id"
    },
    {
      "question": "Which property we use to change text color in CSS?",
      "anwsers": ["color", "text-color", "font-color", "text-style:color"],
      "correct": "color"
    },
    {
      "question": "Which property we use to change the font name?",
      "anwsers": ["font", "font-weight", "font-family", "font-name"],
      "correct": "font-family"
    },
    {
      "question": "Which HTML attribute is used to define inline CSS styles?",
      "anwsers": ["<css>", "<style>"],
      "correct": "<style>"
    },
    {
      "question": "Which property do we change to make text bigger in CSS?",
      "anwsers": ["font-height", "font-weight", "font-size", "text-size"],
      "correct": "font-size"
    },
    {
      "question": "Which property do we change to increase internal spacing in an element?",
      "anwsers": ["padding", "margin", "space", "internal-space"],
      "correct": "padding"
    },
    {
      "question": "How to select all the HTML paragraphs elements?",
      "anwsers": ["p", "#p", ".p", "*p"],
      "correct": "p"
    },
    {
      "question": "How to set a comment in CSS?",
      "anwsers": ["//comment", "/*comment*/"],
      "correct": "/*comment*/"
    },
    {
      "question": "How to set multiple classes to an HTML element?",
      "anwsers": [
        "<div class='class1 class2'>",
        "<div class='class1.class2'>",
        "<div class='class1-class2'>"
      ],
      "correct": "<div class='class1 class2'>"
    },
    {
      "question": "Which property do we use to define the space between words?",
      "anwsers": ["space", "text-space", "word-spacing", "word-space"],
      "correct": "word-spacing"
    },
    {
      "question": "How to transform each start letter of the words in a text to capital letters?",
      "anwsers": ["text-transform:capitalize", "text-transform:uppercase"],
      "correct": "text-transform:capitalize"
    },
    {
      "question": "How do you display hyperlinks without an underline?  ",
      "anwsers": [
        "text-decoration:zero",
        "text-decoration:none",
        "text-decoration:normal",
        "text-decoration:no-underline"
      ],
      "correct": "text-decoration:none"
    },
  ],
  "javascript": [
    {
      "question": "Can you manipulate both CSS and HTML using JavaScript?",
      "anwsers": ["Yes", "Only CSS", "Only HTML"],
      "correct": "Yes"
    },
    {
      "question": "What isn't JavaScript commonly used for?",
      "anwsers": [
        "Front-end development",
        "Back-end development",
        "Mobile development",
        "Machine Learning"
      ],
      "correct": "Machine Learning"
    },
    {
      "question": "When was JavaScript was launched?",
      "anwsers": ["1990", "1995", "2000", "2005"],
      "correct": "1995"
    },
    {
      "question": "Which HTML element do we use to insert JavaScript?",
      "anwsers": ["<js>", "<script>", "<javascript>"],
      "correct": "<script>"
    },
    {
      "question": "How to manipulate an HTML element by it's Id in JavaScript?",
      "anwsers": ["Document.getElementById", "Document.takeElementById", "Document.selectElementId"],
      "correct": "Document.getElementById"
    },
    {
      "question": "How do you print something in the browser console using JavaScript?",
      "anwsers": ["print()", "printf()", "console.log", "System.out.print()"],
      "correct": "console.log"
    },
    {
      "question": "How do you define a variable in JavaScript?",
      "anwsers": ["var", "val", "variable"],
      "correct": "var"
    },
    {
      "question": "Which of these is not a JavaScript framework?",
      "anwsers": ["React", "Django", "Solid", "Vue"],
      "correct": "Django"
    },
    {
      "question": "Which framework do you use to make mobile apps using JavaScript?",
      "anwsers": ["React Native", "Flutter", "Kotlin", "Java Mobile"],
      "correct": "React Native"
    },
    {
      "question": "How do you define an IMUTTABLE variable in JavaScript?",
      "anwsers": ["const", "immu", "immutable"],
      "correct": "const"
    },
    {
      "question": "Is JavaScript a low-level programming language?",
      "anwsers": ["Yes", "No", "Only if you aren't using frameworks"],
      "correct": "No"
    },
    {
      "question": "Which of these isn't a JavaScript framework or run time for BACK-END development?",
      "anwsers": ["Node", "Deno", "Express", "Angular"],
      "correct": "Angular"
    },
    {
      "question": "Which of these isn't one of the JavaScript primitive data types?",
      "anwsers": ["string", "boolean", "number", "dynamic"],
      "correct": "dynamic"
    },
    {
      "question": "How to define an array in JavaScript?",
      "anwsers": ["[]", "{}"],
      "correct": "[]"
    },
    {
      "question": "How to write 'Hello Word' in an alert box?",
      "anwsers": ["alertBox('Hello World')", "alert('Hello Word')", "message('Hello World')"],
      "correct": "alert('Hello Word')"
    },
    {
      "question": "What is a boolean in JavaScript?",
      "anwsers": [
        "A type with only two values: False or True",
        "A big number",
        "A string that can be transformed"
      ],
      "correct": "A type with only two values: False or True"
    },
    {
      "question": "Is JavaScript a weakly typing programming language?",
      "anwsers": ["Yes", "No"],
      "correct": "Yes"
    },
    {
      "question": "Which of these is a SUPERSET of JavaScript?",
      "anwsers": ["NativeScript", "TypeScript", "Java"],
      "correct": "TypeScript"
    },
    {
      "question": "How do you create a function in JavaScript?",
      "anwsers": ["function yourFunction()", "function=yourFunction()", "function:yourFunction()"],
      "correct": "function yourFunction()"
    },
    {
      "question": "How do you compare if two values are equals in Javascript?",
      "anwsers": ["==", "=", "=!", "!="],
      "correct": "=="
    },
  ],
  "phyton": [
    {
      "question": "What's Goku biggesAAAAAAAAAt fear?",
      "anwsers": ["Losing", "Chichi", "Needles", "Vegeta"],
      "correct": "Needles"
    },
    {
      "question": "Who's the first to die in DBZ?",
      "anwsers": ["Raditz", "Farmer", "Nappa", "Goku"],
      "correct": "Farmer"
    },
  ],
  "flutter": [
    {
      "question": "What's Goku biggesAAAAAAAAAt fear?",
      "anwsers": ["Losing", "Chichi", "Needles", "Vegeta"],
      "correct": "Needles"
    },
    {
      "question": "Who's the first to die in DBZ?",
      "anwsers": ["Raditz", "Farmer", "Nappa", "Goku"],
      "correct": "Farmer"
    },
  ]
};
