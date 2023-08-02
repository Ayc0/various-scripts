const hideAdd = () =>
    Array.from(document.querySelectorAll('article'))
        .filter((e) => e.textContent.includes('Promoted') || e.querySelector(':has(svg[aria-label="Verified account"])'))
        .forEach((e) => (e.style = 'display: none'));

window.addEventListener('scroll', hideAdd);
