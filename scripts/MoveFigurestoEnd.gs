// Placeholder text constant
const FIGURE_PLACEHOLDER = "[Figure placeholder]";

function moveFiguresToEnd() {
  const doc = DocumentApp.getActiveDocument();
  const body = doc.getBody();
  
  // Array to store figures and their captions
  const figuresWithCaptions = [];
  
  // Process the document
  processDocument(body, figuresWithCaptions);
  
  // Add figures at the end
  if (figuresWithCaptions.length > 0) {
    body.appendParagraph("Figures Section").setHeading(DocumentApp.ParagraphHeading.HEADING1);
    figuresWithCaptions.forEach(item => {
      const newParagraph = body.appendParagraph('');
      if (item.image) {
        try {
          // Try to copy the image attributes
          const imageBlob = item.image.getBlob();
          const newImage = newParagraph.appendInlineImage(imageBlob);
          
          // Copy image attributes if possible
          try {
            newImage.setWidth(item.image.getWidth());
            newImage.setHeight(item.image.getHeight());
          } catch (e) {
            // Ignore attribute copying errors
          }
        } catch (e) {
          Logger.log('Error copying image: ' + e.toString());
          newParagraph.appendText('[Error: Could not copy image]');
        }
      }
      if (item.caption) {
        body.appendParagraph(item.caption);
      }
      body.appendParagraph(''); // Add spacing
    });
  }
}

function findCaption(body, currentIndex) {
  // Look ahead up to 2 paragraphs for a caption
  for (let i = 1; i <= 2; i++) {
    try {
      const nextIndex = currentIndex + i;
      if (nextIndex >= body.getNumChildren()) break;
      
      const element = body.getChild(nextIndex);
      if (element.getType() === DocumentApp.ElementType.PARAGRAPH) {
        const text = element.asParagraph().getText().trim();
        if (text.startsWith("Figure")) {
          return {
            text: text,
            index: nextIndex
          };
        }
      }
    } catch (e) {
      Logger.log('Error finding caption: ' + e.toString());
      break;
    }
  }
  return null;
}

function processDocument(body, figuresWithCaptions) {
  let i = 0;
  while (i < body.getNumChildren()) {
    try {
      const child = body.getChild(i);
      const type = child.getType();
      
      if (type === DocumentApp.ElementType.PARAGRAPH) {
        const paragraph = child.asParagraph();
        const numElements = paragraph.getNumChildren();
        let hasImage = false;
        
        // Check for inline images within the paragraph
        for (let j = 0; j < numElements; j++) {
          try {
            const element = paragraph.getChild(j);
            if (element.getType() === DocumentApp.ElementType.INLINE_IMAGE) {
              hasImage = true;
              const image = element.asInlineImage();
              const captionInfo = findCaption(body, i);
              
              figuresWithCaptions.push({
                image: image,
                caption: captionInfo ? captionInfo.text : null
              });
              
              // Remove the image from the paragraph
              element.removeFromParent();
              
              // Remove the caption if found
              if (captionInfo) {
                body.removeChild(body.getChild(captionInfo.index));
              }
            }
          } catch (e) {
            Logger.log('Error processing paragraph element: ' + e.toString());
          }
        }
        
        // If paragraph contained images and is now empty, remove it
        if (hasImage && paragraph.getText().trim() === '') {
          body.removeChild(paragraph);
          body.insertParagraph(i, FIGURE_PLACEHOLDER);
        }
        
      } else if (type === DocumentApp.ElementType.INLINE_IMAGE) {
        // Handle standalone inline images
        const image = child.asInlineImage();
        const captionInfo = findCaption(body, i);
        
        figuresWithCaptions.push({
          image: image,
          caption: captionInfo ? captionInfo.text : null
        });
        
        // Replace with placeholder
        body.removeChild(child);
        body.insertParagraph(i, FIGURE_PLACEHOLDER);
        
        // Remove the caption if found
        if (captionInfo) {
          body.removeChild(body.getChild(captionInfo.index));
        }
      }
      
    } catch (e) {
      Logger.log('Error processing document element: ' + e.toString());
    }
    
    i++;
  }
}

function onOpen() {
  DocumentApp.getUi()
    .createMenu('Document Tools')
    .addItem('Move Figures to End', 'moveFiguresToEnd')
    .addToUi();
} 