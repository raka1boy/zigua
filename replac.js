const text1 = "priem@mabiu.ru"; // Replace this with the text you want to replace
const text2 = "info@mabiu.ru "; // Replace this with the text you want to replace it with

element = document.body
    if (element.childNodes.length > 0) {
        element.childNodes.forEach(child => {
            if (child.nodeType === Node.TEXT_NODE) {
                child.textContent = child.textContent.replace(new RegExp("priem@mabiu.ru", 'g'), "info@mabiu.ru");
            }
            else if (child.nodeType === Node.ELEMENT_NODE) {
                replaceTextInElement(child);
            }
        });
    }
