[...document.querySelectorAll('.notifications-list-item')]
    .filter(
        (element) =>
            !!element.querySelector(
                '.octicon-git-pull-request.color-text-danger, .octicon-git-merge'
            )
    )
    .map((el) =>
        el.querySelector(
            ".notification-action-mark-archived button[type='submit'"
        )
    )
    .forEach((el) => el.click());
