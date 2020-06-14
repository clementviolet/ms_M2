"""Fix pagination bug with longtable (at least until v 4.14) and TeXLive

When we use longtable and a float in a Tex document, there is a pagination break.
Some text could be write down below the page, thus not displayed.
There is a fix by addin '\clearpage' at the end of an longtable env.

This small script read the document and add '\clearpage' after a longtable env.
"""

# For file reading
import io

text = []

# Read the .Tex encoded as an utf8 file
with io.open("./rendered/ms_M2.tex", encoding="utf8") as texfile:
    for line in texfile:
        text = texfile.readlines()

# Remove '\usepackage{cleveref}'
text = [sentence.replace('\\usepackage{cleveref}\n', '\n') for sentence in text]

# Write the result into the .Tex file.
with io.open("./rendered/ms_M2.tex", "w", encoding="utf8") as texfile:
    texfile.writelines(text)
