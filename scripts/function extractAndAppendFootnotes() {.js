function extractAndAppendFootnotes() {
    const doc = DocumentApp.getActiveDocument();
    const body = doc.getBody();
    const footnotes = doc.getFootnotes();
  
    // Create a new page at the end of the document.
    body.appendPageBreak();
  
    if (footnotes.length === 0) {
      body.appendParagraph("No footnotes found in this document.");
      return;
    }
  
    body.appendParagraph("Extracted Footnotes:").setHeading(DocumentApp.ParagraphHeading.HEADING1);
  
    footnotes.forEach(footnote => {
      const footnoteBody = footnote.getFootnoteContents();
      const elements = footnoteBody.getParagraphs();
      elements.forEach(element => {
        body.appendParagraph(element.copy());
      });
      body.appendParagraph("---");
    });
}