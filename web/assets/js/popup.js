function closePopup() {
    const popup = document.getElementById("popupMessage");
    if (popup) {
        popup.style.display = "none";
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const popup = document.getElementById("popupMessage");
    if (popup) {
        setTimeout(() => {
            popup.style.display = "none";
        }, 3000);
    }
});
