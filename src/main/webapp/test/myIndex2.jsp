<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>METANIT.COM</title>
    <style>
        #blueRect{
            width:100px;
            height:100px;
            background-color:blue;
        }
    </style>
</head>
<body>
<div id="blueRect"></div>

<script>
    function setColor(e){
        if(e.type==="mouseover")
            e.target.style.backgroundColor = "red";
        else if(e.type==="mouseout")
            e.target.style.backgroundColor = "blue";
    }
    const blueRect = document.getElementById("blueRect");
    blueRect.addEventListener("mouseover", setColor);
    blueRect.addEventListener("mouseout", setColor);
</script>
</body>
</html>