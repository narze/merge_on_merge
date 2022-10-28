# Append on merge

## Workflows

- Contributors create PRs with input files in specified folder e.g. `/input`.
- Github Actions run and create comment with output file change preview
- When merged, the output file will be appended, and input files will be moved to processed folder
- The action could preview how the target file will look like after appending using comments within PRs.
<!--%%% APPEND_ON_MERGE: Puts above this line %%%-->

## Usage

- Copy [.github/workflows/append_on_merge.yml](./.github/workflows/append_on_merge.yml) to your repo
- (Optional) Add comment marker to your target file `<!--%%% APPEND_ON_MERGE: any message here %%%-->`
- Add instruction to create pull request in input folder instead:

```markdown
Do not modify README.md directly (It's managed by append_on_merge GitHub action)
Do not submit Rickroll but with different link, there are too many of them now
Create an entry file in input folder with this link and use this format. (Don't forget - at the front of the entry)
- [Video Name](https://youtu.be/dQw4w9WgXcQ)
Open Pull Request
```

License: MIT