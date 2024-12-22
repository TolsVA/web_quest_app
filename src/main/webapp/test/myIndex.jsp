<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <style>
        body{
            background-color:blue;
        }
    </style>
</head>
<body>
<h1 id="hh"></h1>
<script>
    function setColor(e){
        if(e.type==="mouseover")
            e.target.style.backgroundColor = "red";
        else if(e.type==="mouseout")
            e.target.style.backgroundColor = "blue";
    }

    function handleClick(e){
        console.log("screenX: " + e.screenX);
        console.log("screenY: " + e.screenY);
        console.log("clientX: " + e.clientX);
        console.log("clientY: " + e.clientY);

        const hh = document.getElementById("hh");
        hh.textContent = "clientX: " + e.clientX + " clientY: " + e.clientY;
    }
    const blueRect = document;
    blueRect.addEventListener("click", handleClick);

    blueRect.addEventListener("mouseover", setColor);
    blueRect.addEventListener("mouseout", setColor);
</script>
</body>
</html>