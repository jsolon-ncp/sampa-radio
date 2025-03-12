"""
anonymize_pydicom.py 
from Cursor
Prompt: 
Is there any code in Python or R that can reliably modify DICOM headers so that we can remove or change patient identifiers?
- code provided below
Prompt : DICOM tags like (0x0010, 0x0010) are standardized identifiers defined by the DICOM standard (Digital Imaging and Communications in Medicine). They are organized in a specific way:
Format: (Group Number, Element Number)
Both numbers are in hexadecimal format (hence the 0x prefix)
Each is a 16-bit number (4 hexadecimal digits)
Group Organization:
The first number (0x0010) represents the group
0x0010 is specifically the "Patient" group
Other common groups include:
0x0008: Identifying Information
0x0020: Study Information
0x0028: Image Presentation
Element Numbers:
The second number (0x0010) is the specific element within that group
In this case, 0x0010 within the Patient group (0x0010) is always "Patient's Name"

Reply below 
DICOM tags like (0x0010, 0x0010) are standardized identifiers defined by the DICOM standard (Digital Imaging and Communications in Medicine). They are organized in a specific way:
Format: (Group Number, Element Number)
Both numbers are in hexadecimal format (hence the 0x prefix)
Each is a 16-bit number (4 hexadecimal digits)
Group Organization:
The first number (0x0010) represents the group
0x0010 is specifically the "Patient" group
Other common groups include:
0x0008: Identifying Information
0x0020: Study Information
0x0028: Image Presentation
Element Numbers:
The second number (0x0010) is the specific element within that group
In this case, 0x0010 within the Patient group (0x0010) is always "Patient's Name"

"""

import pydicom
from pathlib import Path
import datetime

def anonymize_dicom(input_path, output_path=None, replacement_dict=None):
    """
    Anonymize a DICOM file by removing or modifying patient identifiers.
    
    Args:
        input_path (str): Path to input DICOM file
        output_path (str, optional): Path to save anonymized DICOM file. If None, overwrites input.
        replacement_dict (dict, optional): Dictionary of {tag: replacement_value} for custom replacements
    """
    # Read the DICOM file
    ds = pydicom.dcmread(input_path)
    
    # Tags that should be anonymized
    tags_to_anonymize = [
        # Patient information
        (0x0010, 0x0010),  # Patient's Name
        (0x0010, 0x0020),  # Patient ID
        (0x0010, 0x0030),  # Patient's Birth Date
        (0x0010, 0x0040),  # Patient's Sex
        (0x0010, 0x1000),  # Other Patient IDs
        (0x0010, 0x1001),  # Other Patient Names
        (0x0010, 0x1010),  # Patient's Age
        (0x0010, 0x1040),  # Patient's Address
        # Physician information
        (0x0008, 0x0090),  # Referring Physician's Name
        (0x0008, 0x0092),  # Referring Physician's Address
        (0x0008, 0x0094),  # Referring Physician's Phone
        # Institution information
        (0x0008, 0x0080),  # Institution Name
        (0x0008, 0x0081)   # Institution Address
    ]
    
    # Default replacements
    default_replacements = {
        'name': 'ANONYMOUS',
        'id': 'ID000000',
        'date': '19000101',
        'age': '000Y',
        'sex': 'O',
        'address': 'ANONYMOUS',
        'phone': '0000000000'
    }
    
    # Apply custom replacements if provided
    if replacement_dict:
        default_replacements.update(replacement_dict)
    
    # Anonymize each tag
    for tag in tags_to_anonymize:
        if tag in ds:
            element = ds[tag]
            if 'Name' in element.name:
                element.value = default_replacements['name']
            elif 'ID' in element.name:
                element.value = default_replacements['id']
            elif 'Date' in element.name:
                element.value = default_replacements['date']
            elif 'Age' in element.name:
                element.value = default_replacements['age']
            elif 'Sex' in element.name:
                element.value = default_replacements['sex']
            elif 'Address' in element.name:
                element.value = default_replacements['address']
            elif 'Phone' in element.name:
                element.value = default_replacements['phone']
            else:
                element.value = ''
    
    # Add anonymization timestamp
    ds.add_new(0x0012, 0x0064, 'DT', datetime.datetime.now().strftime('%Y%m%d%H%M%S'))
    
    # Save the anonymized file
    if output_path:
        ds.save_as(output_path)
    else:
        ds.save_as(input_path)
    
    return ds

# Example usage for a single file
def anonymize_single_file():
    input_file = "path/to/your/dicom/file.dcm"
    output_file = "path/to/output/anonymized.dcm"
    
    # Optional: custom replacements
    custom_replacements = {
        'name': 'RESEARCH_SUBJECT',
        'id': 'STUDY001'
    }
    
    anonymize_dicom(input_file, output_file, custom_replacements)

# Example usage for a directory of DICOM files
def anonymize_directory():
    input_dir = Path("path/to/dicom/directory")
    output_dir = Path("path/to/output/directory")
    output_dir.mkdir(exist_ok=True)
    
    for dicom_file in input_dir.glob("*.dcm"):
        output_file = output_dir / f"anon_{dicom_file.name}"
        anonymize_dicom(str(dicom_file), str(output_file))

if __name__ == "__main__":
    anonymize_single_file()
    # or
    # anonymize_directory()