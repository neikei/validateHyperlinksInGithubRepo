# validateHyperlinksInGithubRepo

Validation of hyperlinks in Github repositories.

## Usage

```bash
bash validateHyperlinksInGithubRepo.sh "<your_Github_repository>"
```

## Example

The following example shows the validation of this Github repository.

```bash
2019-10-27 14:59:12 >> --------------------------------------------------------------------------------
2019-10-27 14:59:12 >> ==> Validate repository URL
2019-10-27 14:59:13 >> https://github.com/neikei/validateHyperlinksInGithubRepo successfully validated
2019-10-27 14:59:13 >>
2019-10-27 14:59:13 >> ==> Download repository from Github
2019-10-27 14:59:13 >> https://github.com/neikei/validateHyperlinksInGithubRepo successfully downloaded
2019-10-27 14:59:13 >>
2019-10-27 14:59:13 >> ==> Find and test all hyperlinks in the repository
2019-10-27 14:59:14 >> OK 200 https://github.com/neikei
2019-10-27 14:59:15 >> OK 200 https://github.com/neikei/syntaxchecks
2019-10-27 14:59:15 >>
2019-10-27 14:59:15 >> ==> Cleanup downloaded repository
2019-10-27 14:59:15 >> validateHyperlinksInGithubRepo-master successfully cleaned up
2019-10-27 14:59:15 >>
2019-10-27 14:59:15 >> ==> Summary | OK: 2 | FAILED: 0
2019-10-27 14:59:15 >> --------------------------------------------------------------------------------
```

## Feedback, Issues and Pull-Requests

Feel free to report issues, fork this project and submit pull requests.
