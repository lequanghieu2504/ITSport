function closePopup() {
    document.getElementById("popupMessage").style.display = "none";
}

setTimeout(() => {
    const popup = document.getElementById("popupMessage");
    if (popup)
        popup.style.display = "none";
}, 3000);
