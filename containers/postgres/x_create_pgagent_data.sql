\connect data

-- Install the pgAgent extension in the main database
CREATE EXTENSION IF NOT EXISTS pgagent;

-- Create new jobs in pgAgent for daily backups
DO $$
DECLARE
    data_job_id INT;
    schedule_id INT;
BEGIN
    -- Step 1: Create a basic job for 'Data' database
    RAISE NOTICE 'Creating job for "Incremental Data Nodes Table Backup Job"...';
    INSERT INTO pgagent.pga_job (jobname, jobdesc, jobenabled, jobjclid)
    VALUES ('Data Node Incremental Backup Job', 'A basic job to incrementally back up the data nodes table', true, 1)
    RETURNING jobid INTO data_job_id;

    RAISE NOTICE 'Job created with ID: %', data_job_id;
    /*
    -- Step 2: Create a job step for the backup
    RAISE NOTICE 'Adding job step for "Data Backup Job"...';
    INSERT INTO pgagent.pga_jobstep (jstjobid, jstname, jstenabled, jstkind, jstcode)
    VALUES (data_job_id, 'Backup data database', true, 'b',
            'pg_dump -U postgres -d data -t node -t relationship -F c -f /backup/data_static.backup');
    RAISE NOTICE 'Job step added for job ID: %', data_job_id;
    */

    INSERT INTO pgagent.pga_jobstep (jstjobid, jstname, jstenabled, jstkind, jstcode)
    VALUES (
        data_job_id,
        'Incremental backup of modified data node rows',
        true,
        'b',
        'pg_dump -U postgres -d data -t node --data-only --column-inserts --file=/backup/data_node_incremental_$(date +%Y%m%d%H%M%S).sql --where="updated > (CURRENT_TIMESTAMP AT TIME ZONE ''UTC'') - INTERVAL ''1 day''"'
    );


    INSERT INTO pgagent.pga_schedule
        (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths)
        VALUES (
            nextval('pgagent.pga_schedule_jscid_seq'::regclass),  -- Auto-increment ID
            data_job_id,                                                 -- Replace with your actual job ID
            'Daily Midnight Job',                                -- Schedule name
            'Runs every day at midnight'::text,                 -- Schedule description
            true,                                                -- Enabled
            CURRENT_TIMESTAMP,                                   -- Start time
            NULL,                                                -- No end date
            '{t,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- 0th minute
            '{t,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- 0th hour (midnight)
            '{t,t,t,t,t,t,t}'::boolean[],                        -- All days of the week
            '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- All month days disabled
            '{f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[]               -- All months disabled
        );

    RAISE NOTICE 'Schedule created for "Data node table incremental Backup Job" with ID: %', schedule_id;

    -- Step 1: Create a basic job for incremental Data relationship table
    
    RAISE NOTICE 'Creating job for "Incremental Data Relationships Table Backup Job"...';
    INSERT INTO pgagent.pga_job (jobname, jobdesc, jobenabled, jobjclid)
    VALUES ('Data Relationships Incremental Backup Job', 'A basic job to incrementally back up the data nodes table', true, 1)
    RETURNING jobid INTO data_job_id;

    RAISE NOTICE 'Job created with ID: %', data_job_id;
    /*
    -- Step 2: Create a job step for the backup
    RAISE NOTICE 'Adding job step for "Data Backup Job"...';
    INSERT INTO pgagent.pga_jobstep (jstjobid, jstname, jstenabled, jstkind, jstcode)
    VALUES (data_job_id, 'Backup data database', true, 'b',
            'pg_dump -U postgres -d data -t node -t relationship -F c -f /backup/data_static.backup');
    RAISE NOTICE 'Job step added for job ID: %', data_job_id;
    */

    INSERT INTO pgagent.pga_jobstep (jstjobid, jstname, jstenabled, jstkind, jstcode)
    VALUES (
        data_job_id,
        'Incremental backup of modified data relationship rows',
        true,
        'b',
        'pg_dump -U postgres -d data -t relationship --data-only --column-inserts --file=/backup/data_relationship_incremental_$(date +%Y%m%d%H%M%S).sql --where="updated > (CURRENT_TIMESTAMP AT TIME ZONE ''UTC'') - INTERVAL ''1 day''"'
    );


    INSERT INTO pgagent.pga_schedule
        (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths)
        VALUES (
            nextval('pgagent.pga_schedule_jscid_seq'::regclass),  -- Auto-increment ID
            data_job_id,                                                 -- Replace with your actual job ID
            'Daily Midnight Job',                                -- Schedule name
            'Runs every day at midnight'::text,                 -- Schedule description
            true,                                                -- Enabled
            CURRENT_TIMESTAMP,                                   -- Start time
            NULL,                                                -- No end date
            '{t,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- 0th minute
            '{f,t,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- 1th hour (midnight)
            '{t,t,t,t,t,t,t}'::boolean[],                        -- All days of the week
            '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- All month days disabled
            '{f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[]               -- All months disabled
        );

    RAISE NOTICE 'Schedule created for "Data Relationship Incremental Backup Job" with ID: %', schedule_id;

 
    -- Final success message
    RAISE NOTICE 'Data job and schedule created successfully!';
END $$;
