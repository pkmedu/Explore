{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "f6e9d29f-b923-483d-8230-7550db4e2d38",
   "metadata": {},
   "source": [
    "\n",
    "[Summer Games Challenge: Lehrer Elements](https://communities.sas.com/t5/SAS-Analytics-Explorer/Summer-Games-Challenge-Lehrer-Elements/ba-p/936801#M1039)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "ec14678e-5dd4-4964-b0e3-107f80478663",
   "metadata": {},
   "outputs": [],
   "source": [
    "/* Step 3: Counting occurrences of the word 'and' */\n",
    "data count_and;\n",
    "set lyrics_lower;\n",
    "\n",
    "and_count = countw(prxchange('s/\\band\\b/and/i', -1, line_lower), 'and');\n",
    "run;"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "9a7e16cb-6e59-449b-bc38-997834a16cd2",
   "metadata": {},
   "outputs": [],
   "source": [
    "\n",
    "\n",
    "proc sql;\n",
    "select sum(and_count) as total_and_count\n",
    "from count_and;\n",
    "quit;"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "bd1d4182-6afc-46d5-be80-5459ef20d113",
   "metadata": {},
   "outputs": [],
   "source": [
    "data elements;\n",
    "\n",
    "  * Reads the text file word by word ;\n",
    "  infile \"C:\\Users\\pmuhuri\\sascourse\\Week2\\Week2data\\patients_drugs.txt\" delimiter=\" \" dsd end=eof;\n",
    "  input word :$60. @@;\n",
    "\n",
    "  * Convert word to lowercase for case-insensitive count;\n",
    "  word = lowcase(word); \n",
    "run;\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "4012baef-bb3c-4ad0-aa1b-c7af1036126a",
   "metadata": {},
   "outputs": [],
   "source": [
    "title1 \"Challenge No IV — Elements and Functions\";\n",
    "title2 \"Count of 'and' Words in TheElements.txt file\";\n",
    "proc gchart data=elements;\n",
    "   pie3d word / cfill=blue othercolor=palegoldenrod otherlabel=\"other\" noheading;\n",
    "run;\n",
    "quit;"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "61995680-d722-448a-beac-383dedea4f41",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "SAS",
   "language": "sas",
   "name": "sas"
  },
  "language_info": {
   "codemirror_mode": "sas",
   "file_extension": ".sas",
   "mimetype": "text/x-sas",
   "name": "sas"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
