VPM is a quick hack I wrote for fun -- feel free to post bug reports and feature 
requests at <https://github.com/awf/vpm/issues> but don't expect instant responses.
The code is at <https://github.com/awf/vpm> so you might even fix things yourself :)

## Running the code.

```
PS> . ./setup # installs HtmlAglityPack
PS> ./make-vpm 'Whistler' # Generates data/Whistler.{md,csv}

PS> ./make-vpm 'Whistler' -checkin # Checks in the new data

PS> git push # update gh pages
```
For areas that don't grep well (e.g. the "Area" field is inconsistently filled in), then you can supply a list of resorts using the `-resorts` option.
