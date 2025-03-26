/*
table_equipment
Sampa
J. Solon
March 26
*/

import delimited using "./data-temp/Radio_Paper - equipment_raw.csv", varnames(1) delim(",") clear	
sort id type cohort

la var type "Equipment"
la var cohort "Cohort"
la var make_model "Make & Model"
la var health_facility "Health Facility"
la var city_country "City, Country"

local varlist "type cohort make_model health_facility city_country"

local title ""
local filename "table_equipment.docx"

putdocx clear
putdocx begin, font(Arial, 11) pagenum(decimal) footer(npage)
putdocx paragraph, style(Title)
putdocx text ("`title'")

// Column Headings 
putdocx table equipment = data(`varlist')
putdocx table equipment(1,1) = ("Equipment")
putdocx table equipment(1,2) = ("Cohort")
putdocx table equipment(1,3) = ("Make & Model")
putdocx table equipment(1,4) = ("Health Facility")
putdocx table equipment(1,5) = ("City, Country")

// Remove bottom borders for rows 2-5 and 7 to 10
putdocx table equipment(2(1)5,1), border(bottom, nil)
putdocx table equipment(7(1)10,1), border(bottom, nil)

// Remove Text
putdocx table equipment(2,1) = ("Ultrasound")
putdocx table equipment(3,1) = ("")
putdocx table equipment(4,1) = ("")
putdocx table equipment(5,1) = ("")
putdocx table equipment(6,1) = ("")
putdocx table equipment(7,1) = ("CT Scan")

putdocx table equipment(8,1) = ("")
putdocx table equipment(9,1) = ("")
putdocx table equipment(10,1) = ("")
putdocx table equipment(11,1) = ("")

// To remove text from specific cells, use:
// putdocx table equipment(1,1) = ("")  // Removes text from cell in row 1, column 1
// putdocx table equipment(2,3) = ("")  // Removes text from cell in row 2, column 3

putdocx save ./tables/`filename', replace
