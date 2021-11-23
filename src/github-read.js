[...document.querySelectorAll('.notifications-list-item')]
    .filter(
        (element) =>
            !!element.querySelector(
                '.octicon-git-pull-request-closed, .octicon-git-merge, .octicon-issue-closed'
            )
    )
    .map((el) =>
        el.querySelector(
            ".notification-action-mark-archived button[type='submit']"
        )
    )
    .forEach((el) => el.click());
