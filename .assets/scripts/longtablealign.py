"""Left align longtable TeXLive

When we use longtable and a float in a Tex document, there is a pagination break.
Some text could be write down below the page, thus not displayed.
There is a fix by addin '\clearpage' at the end of an longtable env.

This small script read the document and add '\clearpage' after a longtable env.
"""

# For file reading
import io

text = []

# Read the .Tex encoded as an utf8 file
with io.open("./rendered/thanks_glossary_math.tex", encoding="utf8") as texfile:
    for line in texfile:
        text = texfile.readlines()

# Add '\clearpage' at the end of the longtable env
text = [sentence.replace('\\begin{longtable}[]{@{}ll@{}}\n', '\\begin{longtable}[l]{@{}ll@{}}\n') for sentence in text]

# Write the result into the .Tex file.
with io.open("./rendered/thanks_glossary_math.tex", "w", encoding="utf8") as texfile:
    texfile.writelines(text)
