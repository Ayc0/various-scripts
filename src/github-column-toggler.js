(function () {
    const left = `body[data-github-display-col='left']`;
    const right = `body[data-github-display-col='right']`;

    const getCol = (n) => `table.diff-table colgroup > col:nth-child(${n})`;

    const getColumn = (n) =>
        `table.diff-table tr[data-hunk] > td:nth-child(${n})`;

    const styles = `
    body[data-github-display-col] table.diff-table.file-diff-split {
         table-layout: auto !important;
    }


    ${left} ${getCol(1)},
    ${left} ${getCol(2)},
    ${left} ${getColumn(1)},
    ${left} ${getColumn(2)} {
        display: none;
    }

    ${right} ${getCol(3)},
    ${right} ${getCol(4)},
    ${right} ${getColumn(3)},
    ${right} ${getColumn(4)} {
        display: none;
    }
    `;

    const el = document.getElementById('ayc0-github-toggler');
    if (!el) {
        const style = document.createElement('style');
        style.innerHTML = styles;
        style.setAttribute('id', 'ayc0-github-toggler');
        document.head.appendChild(style);
    }
    const current = document.body.dataset.githubDisplayCol;
    if (current === undefined) {
        document.body.dataset.githubDisplayCol = 'left';
    } else if (current === 'left') {
        document.body.dataset.githubDisplayCol = 'right';
    } else {
        delete document.body.dataset.githubDisplayCol;
    }
})();
