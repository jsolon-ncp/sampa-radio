// Placeholder text constant
const TABLE_PLACEHOLDER = "[Table placeholder]";

function moveTablesToEnd() {
  const doc = DocumentApp.getActiveDocument();
  const body = doc.getBody();
  
  // Array to store tables with their captions
  const tablesWithCaptions = [];
  
  // Process the document
  processDocument(body, tablesWithCaptions);
  
  // Add tables at the end
  if (tablesWithCaptions.length > 0) {
    body.appendParagraph("Tables Section").setHeading(DocumentApp.ParagraphHeading.HEADING1);
    tablesWithCaptions.forEach(item => {
      const newTable = body.appendTable(item.table.copy());
      if (item.caption) {
        body.appendParagraph(item.caption);
      }
      body.appendParagraph(''); // Add spacing
    });
  }
}

function processDocument(body, tablesWithCaptions) {
  const numChildren = body.getNumChildren();
  
  for (let i = 0; i < numChildren; i++) {
    const child = body.getChild(i);
    const type = child.getType();
    
    if (type === DocumentApp.ElementType.TABLE) {
      // Handle tables
      const table = child.asTable();
      let caption = findCaption(body, i + 1);
      
      tablesWithCaptions.push({
        table: table,
        caption: caption
      });
      
      // Replace with placeholder
      if (table.removeFromParent()) {
        body.insertParagraph(i, TABLE_PLACEHOLDER);
      }
      
      // Remove the caption if found
      if (caption) {
        body.removeChild(body.getChild(i + 1));
      }
    }
  }
}

function findCaption(body, startIndex) {
  if (startIndex >= body.getNumChildren()) return null;
  
  const nextElement = body.getChild(startIndex);
  if (nextElement.getType() === DocumentApp.ElementType.PARAGRAPH) {
    const text = nextElement.asParagraph().getText();
    if (text.trim().startsWith("Table")) {
      return text;
    }
  }
  return null;
}

function onOpen() {
  DocumentApp.getUi()
    .createMenu('Document Tools')
    .addItem('Move Tables to End', 'moveTablesToEnd')
    .addToUi();
} 