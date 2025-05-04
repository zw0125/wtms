<?php
header('Content-Type: application/json');
include_once("db_config.php");

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Validate required fields
    $required_fields = ['full_name', 'email', 'password'];
    $missing_fields = [];
    
    foreach ($required_fields as $field) {
        if (!isset($_POST[$field]) || empty($_POST[$field])) {
            $missing_fields[] = $field;
        }
    }
    
    if (!empty($missing_fields)) {
        $response['success'] = false;
        $response['message'] = 'Missing required fields: ' . implode(', ', $missing_fields);
        echo json_encode($response);
        exit();
    }

    $full_name = $_POST['full_name'];
    $email = $_POST['email'];
    $password = sha1($_POST['password']); // Hash password
    $phone = isset($_POST['phone']) ? $_POST['phone'] : '';
    $address = isset($_POST['address']) ? $_POST['address'] : '';

    // Check if email exists
    $check_sql = "SELECT * FROM workers WHERE email = ?";
    $check_stmt = $conn->prepare($check_sql);
    $check_stmt->bind_param("s", $email);
    $check_stmt->execute();
    $result = $check_stmt->get_result();

    if ($result->num_rows > 0) {
        $response['success'] = false;
        $response['message'] = 'Email already registered';
    } else {
        // Insert new worker
        $sql = "INSERT INTO workers (full_name, email, password, phone, address) VALUES (?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sssss", $full_name, $email, $password, $phone, $address);
        
        if ($stmt->execute()) {
            $response['success'] = true;
            $response['message'] = 'Registration successful';
        } else {
            $response['success'] = false;
            $response['message'] = 'Registration failed: ' . $stmt->error;
        }
        $stmt->close();
    }
    $check_stmt->close();
} else {
    $response['success'] = false;
    $response['message'] = 'Invalid request method';
}

echo json_encode($response);
$conn->close();
?>