<?php
header('Content-Type: application/json');
include_once("db_config.php");

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['worker_id'])) {
        $worker_id = $_POST['worker_id'];
        
        try {
            $sql = "SELECT * FROM tbl_works WHERE assigned_to = ? ORDER BY due_date ASC";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("i", $worker_id);
            $stmt->execute();
            $result = $stmt->get_result();
            
            $works = array();
            while ($row = $result->fetch_assoc()) {
                $works[] = array(
                    'id' => $row['id'],
                    'title' => $row['title'],
                    'description' => $row['description'],
                    'assigned_to' => $row['assigned_to'],
                    'date_assigned' => $row['date_assigned'],
                    'due_date' => $row['due_date'],
                    'status' => $row['status']
                );
            }
            
            $response['success'] = true;
            $response['works'] = $works;
            
        } catch (Exception $e) {
            $response['success'] = false;
            $response['message'] = 'Database error: ' . $e->getMessage();
        }
    } else {
        $response['success'] = false;
        $response['message'] = 'Worker ID is required';
    }
} else {
    $response['success'] = false;
    $response['message'] = 'Invalid request method';
}

echo json_encode($response);
$conn->close();
?>