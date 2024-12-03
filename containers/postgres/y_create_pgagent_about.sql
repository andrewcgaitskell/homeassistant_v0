\connect about

-- Install the pgAgent extension in the main database
CREATE EXTENSION IF NOT EXISTS pgagent;

-- Create new jobs in pgAgent for daily backups
DO $$
DECLARE
    about_job_id INT;
    schedule_id INT;
    timestamp_suffix TEXT;
    backup_command TEXT;
BEGIN
    -- Step 1: Create a basic job for 'About' database
    RAISE NOTICE 'Creating job for "About Backup Job"...';
    INSERT INTO pgagent.pga_job (jobname, jobdesc, jobenabled, jobjclid)
    VALUES ('About Backup Job', 'A basic job to back up the about database', true, 1)
    RETURNING jobid INTO about_job_id;

    RAISE NOTICE 'Job created with ID: %', about_job_id;

    -- Step 2: Create a job step for the backup
    /*
    RAISE NOTICE 'Adding job step for "Data Backup Job"...';
    INSERT INTO pgagent.pga_jobstep (jstjobid, jstname, jstenabled, jstkind, jstcode)
    VALUES (about_job_id, 'Backup about database', true, 'b',
            'pg_dump -U postgres -d about -t node -t relationship -F c -f /backup/about_static.backup');
    RAISE NOTICE 'Job step added for job ID: %', about_job_id;
    */

    /*
    INSERT INTO pgagent.pga_jobstep (jstjobid, jstname, jstenabled, jstkind, jstcode)
    VALUES (
        about_job_id,
        'Backup about database',
        true,
        'b',
        'pg_dump -U postgres -d about -t node -t relationship -F c -f /backup/about_$(date +%Y%m%d%H%M%S).backup'
    );
    RAISE NOTICE 'Job step added for job ID: %', about_job_id;
    */

    INSERT INTO pgagent.pga_jobstep (jstjobid, jstname, jstenabled, jstkind, jstcode)
    VALUES (
        about_job_id,
        'Incremental backup of modified rows',
        true,
        'b',
        'pg_dump -U postgres -d about -t node --data-only --column-inserts --file=/backup/node_incremental_$(date +%Y%m%d%H%M%S).sql --where="updated_at > (CURRENT_TIMESTAMP AT TIME ZONE ''UTC'') - INTERVAL ''1 day''"'
    );


    RAISE NOTICE 'Incremental backup job step added for job ID: %', about_job_id;


    INSERT INTO pgagent.pga_schedule
        (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths)
        VALUES (
            nextval('pgagent.pga_schedule_jscid_seq'::regclass),  -- Auto-increment ID
            about_job_id,                                                 -- Replace with your actual job ID
            'Daily Midnight Job',                                -- Schedule name
            'Runs every day at midnight'::text,                 -- Schedule description
            true,                                                -- Enabled
            CURRENT_TIMESTAMP,                                   -- Start time
            NULL,                                                -- No end date
            '{f,f,f,f,f,t,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- 5th minute
            '{t,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- 0th hour (midnight)
            '{t,t,t,t,t,t,t}'::boolean[],                        -- All days of the week
            '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[], -- All month days disabled
            '{f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[]               -- All months disabled
        );

    RAISE NOTICE 'Schedule created for "About Backup Job" with ID: %', schedule_id;

 
    -- Final success message
    RAISE NOTICE 'About job and schedule created successfully!';
END $$;
