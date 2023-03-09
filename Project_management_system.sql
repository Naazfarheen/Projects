CREATE TABLE portfolio.projects (
  project_id INT PRIMARY KEY,
  project_name VARCHAR(50),
  project_type VARCHAR(20),
  budget DECIMAL(10,2),
  start_date DATE,
  end_date DATE,
  status VARCHAR(20)
);
CREATE TABLE portfolio.tasks (
  task_id INT PRIMARY KEY,
  task_name VARCHAR(50),
  description TEXT,
  assigned_employee VARCHAR(50),
  start_date DATE,
  end_date DATE,
  status VARCHAR(20),
  project_id INT,
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
INSERT INTO portfolio.projects (project_id, project_name, project_type, budget, start_date, end_date, status)
VALUES (1, 'Project A', 'Software Development', 50000.00, '2023-01-01', '2023-06-30', 'In Progress'),
       (2, 'Project B', 'Marketing Campaign', 10000.00, '2023-02-15', '2023-05-30', 'Completed'),
       (3, 'Project C', 'Research', 75000.00, '2023-03-01', '2023-12-31', 'Planned'),
       (4, 'Project D', 'Software Development', 100000.00, '2023-02-01', '2023-03-31', 'In Progress');
       
       INSERT INTO portfolio.tasks (task_id, task_name, description, assigned_employee, start_date, end_date, status, project_id)
VALUES (1, 'Task 1', 'Develop feature A', 'John Smith', '2023-01-01', '2023-03-31', 'In Progress', 1),
       (2, 'Task 2', 'Create marketing materials', 'Sarah Jones', '2023-02-15', '2023-04-15', 'Completed', 2),
       (3, 'Task 3', 'Conduct research on topic A', 'Emily Johnson', '2023-03-01', '2023-06-30', 'In Progress', 3),
       (4, 'Task 4', 'Develop feature B', 'John Smith', '2023-04-01', '2023-06-30', 'Planned', 1),
       (5, 'Task 5', 'Analyze data on topic A', 'Emily Johnson', '2023-03-01', '2023-06-30', 'In Progress', 3),
       (6, 'Task 6', 'Design user interface', 'David Lee', '2023-04-01', '2023-07-31', 'In Progress', 4),
       (7, 'Task 7', 'Develop feature C', 'John Smith', '2023-05-01', '2023-09-30', 'Planned', 1);
       
	Q.1 What is the total budget allocated for all the projects?
       SELECT SUM(budget) AS total_budget FROM portfolio.projects;
	    total_budget= 235000
        
	Q.2 How many projects are in progress?
        SELECT COUNT(*) AS num_projects_in_progress FROM portfolio.projects WHERE status = 'In Progress';
        total project=2 
        
	Q.3 Which project has the highest budget?
    SELECT project_name, budget FROM portfolio.projects WHERE budget = (SELECT MAX(budget) FROM portfolio.projects);
     project D =100000
     
	Q.4 How many tasks are assigned to each employee?
    SELECT assigned_employee, COUNT(*) AS num_tasks_assigned FROM portfolio.tasks GROUP BY assigned_employee;
    David Lee	1
    Emily Johnson	2
	John Smith	3
	Sarah Jones	1

Q.5 What is the average budget for software development projects?
SELECT AVG(budget) AS avg_budget FROM portfolio.projects WHERE project_type = 'Software Development';
75000

Q.6 Which project has the most number of tasks?
SELECT project_name, COUNT(*) AS num_tasks 
FROM portfolio.tasks INNER JOIN portfolio.projects
 ON tasks.project_id = projects.project_id 
 GROUP BY tasks.project_id ORDER BY num_tasks DESC LIMIT 1;
 Project A	3

Q.7 What is the average duration of completed projects?
  SELECT AVG(DATEDIFF(end_date, start_date))
  AS avg_duration_completed_projects
  FROM portfolio.projects 
  WHERE status = 'Completed';
  104 days
  
  Q.8 Which task has the longest duration?
  SELECT task_name, DATEDIFF(end_date, start_date) AS duration
  FROM portfolio.tasks ORDER BY duration DESC LIMIT 1;
  Task 7	152
    
 Q.9 What is the total budget allocated for each project type?
 SELECT project_type, SUM(budget) AS total_budget
 FROM portfolio.projects 
 GROUP BY project_type;
 Marketing Campaign	    10000.00
 Research	            75000.00
 Software Development	150000.00
 
 Q.10 How many tasks are in progress for each project?
 SELECT project_name, COUNT(*) AS num_tasks_in_progress
 FROM portfolio.tasks
 INNER JOIN portfolio.projects
 ON tasks.project_id = projects.project_id
 WHERE tasks.status = 'In Progress' GROUP BY tasks.project_id;
Project A	1
Project C	2
Project D	1

       