window.addEventListener("click", (event) => {
    if (event.shiftKey) {
        alert(`Event name: ${event.type}`);
    } else if (event.ctrlKey) {
        alert(`Element name: <${event.target.tagName.toLowerCase()}>`);
    }
});