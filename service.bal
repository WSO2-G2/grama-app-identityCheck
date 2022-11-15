import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/http;

mysql:Client mysqlEp = check new (host = "workzone.c6yaihe9lzwl.us-west-2.rds.amazonaws.com", user = "admin", password = "Malithi1234", database = "gramaIdentityCheck", port = 3306);

type person record {
    int userId;
    string nic;
    string name;
};

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    resource function get getPerson(string nic) returns boolean|error? {

        person|error queryRowResponse =  mysqlEp->queryRow(sqlQuery = `SELECT * FROM person WHERE nic = ${nic}`);
        
        error? e =  mysqlEp.close();

        if(e is error){
            return e;
        }

        if(queryRowResponse is error){
            return false;
        }
        else{
            return true;
        }
    }
}
