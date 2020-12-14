const hideAdd = () =>
    Array.from(document.querySelectorAll('article'))
        .filter((e) => e.textContent.includes('Promoted'))
        .forEach((e) => (e.style = 'display: none'));
window.addEventListener('scroll', hideAdd);
