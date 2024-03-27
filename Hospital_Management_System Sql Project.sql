use hosplital;

-- 1. write a SQL query to find out which nurses have not yet been registered. Return all the fields of nurse table. --
select * from nurse where registered ='f';

-- 2. write a SQL query to identify the nurses in charge of each department. Return nursename as “name”, Position as “Position”. --
select name, position from nurse where position= 'Head Nurse';

-- 3. write a SQL query to identify the physicians who are the department heads. Return Department name as “Department” and Physician name as “Physician”. --
select d.name as "Department", p.name as "Physician" from physician p,
department d where d.head=p.employeeid;

-- 4. write a SQL query to count the number of patients who scheduled an appointment with at least one physician. Return count as "Number of patients taken at least one appointment". --
select count(Distinct patient) as "Number of patient taken at least one appointment" from appointment
where physician >1;

-- 5.  write a SQL query to locate the floor and block where room number 212 is located. Return block floor as "Floor" and block code as "Block". --
select blockfloor as "Floor", blockcode as "Block" from room where roomnumber = 212;

-- 6. write a SQL query to count the number available rooms. Return count as "Number of available rooms" --
select count(unavailable) as "Number of available rooms" from room
where unavailable = 'f';

-- 7. write a SQL query to count the number of unavailable rooms. Return count as "Number of unavailable rooms". --
select count(unavailable) as "Number of unavailable rooms" from room
where unavailable = 't';

-- 8. write a SQL query to identify the physician and the department with which he or she is affiliated. Return Physician name as "Physician", and department name as "Department". --
select physician.name as "Physician", department.name AS "Department"
from physician
join affiliated_with on physician.employeeid = affiliated_with.physician
join  department on affiliated_with.department = department.department_id ;

-- 9. write a SQL query to find those physicians who have received special training. Return Physician name as “Physician”, treatment procedure name as "Treatment". --
select physician.name as "Physician", procedures.name as "Treatment"
from physician join trained_in on physician.employeeid=trained_in.physician
join procedures on trained_in.treatment = procedures.code;

-- 10. write a SQL query to find those physicians who are yet to be affiliated. Return Physician name as "Physician", Position, and department as "Department". -
select physician.name as "physician", physician.position, department.name as "Department"
from physician join affiliated_with on physician=employeeid = affiliated_with.physician
join department on department.department_id = affiliated_with.department 
where affiliated_with.primaryaffiliation = 'false';

-- 11. write a SQL query to identify physicians who are not specialists. Return Physician name as "Physician", position as "Designation". --
select physician.name as "physician", physician .position as "Designation" from physician 
left join trained_in on physician.employeeid = trained_in.physician 
where trained_in.treatment is null 
order by  physician.name;

-- 12. write a SQL query to find the patients with their physicians by whom they received preliminary treatment. Return Patient name as "Patient", address as "Address" and Physician name as "Physician". --
select patient.name as "Patient", patient.address as "Address", physician.name as "Physician"
from patient join physician on patient.pcp = physician.employeeid;

-- 13. write a SQL query to identify the patients and the number of physicians with whom they have scheduled appointments. Return Patient name as "Patient", number of Physicians as "Appointment for No. of Physicians". --
select count(appointment.patient) as "Appointment for No. of Physician", patient.name as "patient"
from patient join appointment on patient.ssn = appointment.patient 
group by patient.name
having count(appointment.patient) > 1;

-- 14. write a SQL query to count the number of unique patients who have been scheduled for examination room 'C'. Return unique patients as "No. of patients got appointment for room C". --
select count(distinct patient) as "No. of patients got appointment for room C" from appointment 
where examinationroom = 'C';

-- 15. write a SQL query to find the names of the patients and the room number where they need to be treated. Return patient name as "Patient", examination room as "Room No.", and starting date time as Date "Date and Time of appointment". --
select patient.name as "Patient", appointment.examinationroom as "Room No", appointment.start_dt as "Date and Time of appointment"
from appointment join patient on patient.ssn = appointment.patient;

-- 16. write a SQL query to identify the nurses and the room in which they will assist the physicians. Return Nurse Name as "Name of the Nurse" and examination room as "Room No.". --
select nurse.name as "Name of the Nurse", appointment.examinationroom as "Room No" from nurse
join appointment on nurse.employeeid = appointment.prepnurse;

-- 17.  write a SQL query to locate the patients who attended the appointment on the 25th of April at 10 a.m. Return Name of the patient, Name of the Nurse assisting the physician, Physician Name as "Name of the physician", examination room as "Room No.", schedule date and approximate time to meet the physician. --
select patient.name as "Patient_name", nurse.name as "Name of the Nurse assisting the physician", physician.name as "Name of the Physician", appointment.examinationroom as "Room No" ,
appointment.start_dt from patient join appointment on patient.ssn = appointment.patient
join nurse on nurse.employeeid = appointment.prepnurse
join physician on physician.employeeid  = appointment.physician
where appointment.start_dt = '2008-04-25 10:00:00';

-- 18.  write a SQL query to identify those patients and their physicians who do not require any nursing assistance. Return Name of the patient as "Name of the patient", Name of the Physician as "Name of the physician" and examination room as "Room No." --
select patient.name as "Name of patient", physician.name as "Name of Physician", appointment.examinationroom as "Room No"
from patient join appointment on patient.ssn = appointment.patient
join physician on physician.employeeid = appointment.physician
where appointment.prepnurse is null;

-- 19. write a SQL query to locate the patients' treating physicians and medications. Return Patient name as "Patient", Physician name as "Physician", Medication name as "Medication" --
select patient.name as "patient", physician.name as "physician", medication.name as "Medication"
from patient join prescribes on patient.ssn = prescribes.patient
join physician on physician.employeeid = prescribes.physician
join medication on prescribes.medication = medication.code;

-- 20. write a SQL query to count the number of available rooms in each block. Sort the result-set on ID of the block. Return ID of the block as "Block", count number of available rooms as "Number of available rooms". --
select blockcode as "Block", count(unavailable) from room
where unavailable = 'f'
group by 1
order by 1;

-- 21. write a SQL query to count the number of available rooms in each floor. Sort the result-set on block floor. Return floor ID as "Floor" and count the number of available rooms as "Number of available rooms". --
select blockfloor as "Floor", count(unavailable) as "Number of avilable rooms" from room
where unavailable = 'f'
group by 1;

-- 22. write a SQL query to count the number of available rooms for each floor in each block. Sort the result-set on floor ID, ID of the block. Return the floor ID as "Floor", ID of the block as "Block", and number of available rooms as "Number of available rooms". --
select blockfloor as "Floor", blockcode as "Block", count(unavailable) as  "Number of available rooms"
from room where unavailable ='f'
group by 1,2
order by 1;

-- 23. write a SQL query to count the number of rooms that are unavailable in each block and on each floor. Sort the result-set on block floor, block code. Return the floor ID as "Floor", block ID as "Block", and number of unavailable as “Number of unavailable rooms". --
select blockfloor as "Floor", blockcode as "Block", count(unavailable) as  "Number of available rooms"
from room where unavailable ='t'
group by 1,2
order by 1;

-- 24. write a SQL query to find the floor where the maximum number of rooms are available. Return floor ID as "Floor", count "Number of available rooms". --
select blockfloor as "Floor", count(unavailable) as "Number of available rooms" from room
where unavailable = 'f'
group by 1 ;

-- 25. write a SQL query to find out, which nurses have been on call for room 122 in the past. Return name of the nurses. ---
select n.name from nurse n where employeeid in
(select oc.nurse from on_call oc, room r
where oc.blockfloor = r.blockfloor
and oc.blockcode = r.blockcode
and r.roomnumber = 122 );

    
