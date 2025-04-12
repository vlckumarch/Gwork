SELECT 
    r.report_sequence,
    c.client_sequence,
    c.client AS client_code,
    c.clientname AS latest_clientname,
    rs.sts_code AS latest_status,
    rs.insert_date
FROM report r
JOIN client c ON r.client_sequence = c.client_sequence
JOIN (
    SELECT rs1.report_sequence, rs1.sts_code, rs1.insert_date
    FROM report_status rs1
    INNER JOIN (
        SELECT report_sequence, MAX(insert_date) AS max_insert_date
        FROM report_status
        GROUP BY report_sequence
    ) rs2 ON rs1.report_sequence = rs2.report_sequence AND rs1.insert_date = rs2.max_insert_date
) rs ON r.report_sequence = rs.report_sequence;
