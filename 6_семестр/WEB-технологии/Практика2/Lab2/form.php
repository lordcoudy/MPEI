<?php
$lastName = $_POST['lastName'];
$firstName = $_POST['firstName'];
$middleName = $_POST['middleName'];
$address = $_POST['address'];
$tel = $_POST['tel'];
$mail = $_POST['mail'];
$date = $_POST['deliveryDate'];
$time = $_POST['deliveryTime'];
$type = $_POST['type'];
$quantity = $_POST['quantity'];
$price = $_POST['price'];
$flower = $_POST['flower'];
$colour = $_POST['colour'];
$express = $_POST['express'];
$comment = $_POST['comment'];

if (!isset($lastName))
{

    $lastName = 'не выбран';
}
if (!isset($firstName))
{

    $firstName = 'не выбран';
}
if (!isset($middleName))
{

    $middleName = 'не выбран';
}
if (!isset($address))
{

    $address = 'не выбран';
}
if (!isset($tel))
{

    $tel = 'не выбран';
}
if (!isset($mail))
{

    $mail = 'не выбран';
}
if (!isset($date))
{

    $date = 'не выбран';
}
if (!isset($time))
{

    $time = 'не выбран';
}
if (!isset($type))
{

    $type = 'не выбран';
}
if (!isset($quantity))
{

    $quantity = 'не выбран';
}
if (!isset($price))
{

    $price = 'не выбран';
}
if (!isset($flower))
{

    $flower = 'не выбран';
}
if (!isset($colour))
{

    $colour = 'не выбран';
}
if (!isset($express))
{

    $express = 'не выбран';
}
if (!isset($comment))
{

    $comment = 'не выбран';
}


$servername = "localhost";
$username = "root";
$password = "Pdtpl0ktn";
$dbname = "sys";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "INSERT INTO clients (clientLastName, clientName, clientMiddleName, clientAddress, clientPhone, clientMail, orderDate, orderTime, orderBuckType, orderQuant, orderFlower, orderColour, orderExtra, orderComment, orderPrice)
VALUES ('$lastName', '$firstName', '$middleName', '$address', '$tel', '$mail', '$date', '$time', '$type', '$quantity', '$flower', '$colour', '$express', '$comment', '$price')";

if ($conn->query($sql) === TRUE) {
    echo "New record created successfully\n";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$sql = "SELECT * FROM clients";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "Last name: " . $row["clientLastName"]. "<br>" .
            " - Name: " . $row["clientName"]. "<br>" .
            " - Middle name " . $row["clientMiddleName"]. "<br>" .
            " - Address " . $row["clientAddress"]. "<br>" .
            " - Phone " . $row["clientPhone"]. "<br>" .
            " - E-mail " . $row["clientMail"]. "<br>" .
            " - Date " . $row["orderDate"]. "<br>" .
            " - Time " . $row["orderTime"]. "<br>" .
            " - Bucket Type " . $row["orderBuckType"]. "<br>" .
            " - Quantity " . $row["orderQuant"]. "<br>" .
            " - Flower " . $row["orderFlower"]. "<br>" .
            " - Colour " . $row["orderColour"]. "<br>" .
            " - Extra " . $row["orderExtra"]. "<br>" .
            " - Comment " . $row["orderComment"]. "<br>" .
            " - Price " . $row["orderPrice"]. "<br>";
    }
} else {
    echo "0 results";
}

$conn->close();