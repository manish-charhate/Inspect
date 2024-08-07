## Assumptions:

1. We should let user create new inspections by tapping "+" button where inspection has its own progress.
3. We should let user submit inspection category wise.
4. On answering all questions of an inspection, submit inspection using API `api/inspections/submit` by passing complete inspection model as request body but with updated values of `selectedAnswerChoiceId`
5. User session is not maintained. So on each app launch, user has to login.
