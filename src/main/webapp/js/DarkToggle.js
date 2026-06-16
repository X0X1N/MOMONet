const toggleBtn = document.getElementById("themeToggle");
const root = document.documentElement;

function setTheme(isLight) {
    if (isLight) {
        root.classList.add("light");
        toggleBtn.style.left = "32px";
        toggleBtn.querySelector("img").src = "images/sun.png";
        localStorage.setItem("theme", "light");
    } else {
        root.classList.remove("light");
        toggleBtn.style.left = "2px";
        toggleBtn.querySelector("img").src = "images/dark.png";
        localStorage.setItem("theme", "dark");
    }
  
}

window.onload = () => {
    const savedTheme = localStorage.getItem("theme");
    setTheme(savedTheme === "light");  
};

toggleBtn.addEventListener("click", (e) => {
    e.preventDefault();
    const isNowLight = !root.classList.contains("light");
    setTheme(isNowLight);
});
