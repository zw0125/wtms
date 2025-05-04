<?php
header('Content-Type: application/json');
include_once("db_config.php");

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['email']) && isset($_POST['password'])) {
        $email = $_POST['email'];
        $password = sha1($_POST['password']); // Hash password using SHA1

        try {
            $sql = "SELECT * FROM workers WHERE email = ? AND password = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ss", $email, $password);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows == 1) {
                $worker = $result->fetch_assoc();
                $response['success'] = true;
                $response['message'] = 'Login successful';
                $response['worker'] = array(
                    'id' => $worker['id'],
                    'full_name' => $worker['full_name'],
                    'email' => $worker['email'],
                    'phone' => $worker['phone'],
                    'address' => $worker['address']
                );
            } else {
                $response['success'] = false;
                $response['message'] = 'Invalid email or password';
            }
        } catch (Exception $e) {
            $response['success'] = false;
            $response['message'] = 'Database error: ' . $e->getMessage();
        }
    } else {
        $response['success'] = false;
        $response['message'] = 'Email and password are required';
    }
} else {
    $response['success'] = false;
    $response['message'] = 'Invalid request method';
}

echo json_encode($response);
$conn->close();
?>