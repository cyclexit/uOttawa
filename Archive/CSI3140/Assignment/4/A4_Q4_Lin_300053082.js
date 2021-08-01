const moveableImg = document.getElementById("moveable-img");

moveableImg.onmousedown = (event) => {
    var mouseX = event.clientX, mouseY = event.clientY;
    var newX = 0, newY = 0;
    event.preventDefault();

    document.onmousemove = (event) => {
        newX = moveableImg.offsetLeft - (mouseX - event.clientX);
        newY = moveableImg.offsetTop - (mouseY - event.clientY);
        moveableImg.style.top = `${newY}px`;
        moveableImg.style.left = `${newX}px`;
        mouseX = event.clientX;
        mouseY = event.clientY;
    }

    document.onmouseup = () => {
        document.onmousemove = null;
    }
}