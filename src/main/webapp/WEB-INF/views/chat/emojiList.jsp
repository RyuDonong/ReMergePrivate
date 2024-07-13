<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Emoji List</title>
</head>
<body>
    <h1>Emoji List</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Character</th>
                <th>Unicode Name</th>
                <th>Group</th>
                <th>Sub Group</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="emoji" items="${emojis}">
                <tr>
                    <td>${emoji.character}</td>
                    <td>${emoji.unicodeName}</td>
                    <td>${emoji.group}</td>
                    <td>${emoji.subGroup}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
