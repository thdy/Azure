Connect-AzureAD
$app_name = "<AppName>"
$app_role_name = "User"
$groupId = Get-AzureADGroup -SearchString "<GroupeName>"

$ary_names = Get-AzureADGroupMember -ObjectId $groupId.ObjectId | Select-Object Mail
foreach($username in $ary_names){
    $user = Get-AzureADUser -ObjectId $username.Mail
    $sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
    $appRole = $sp.AppRoles | Where-Object { $_.DisplayName -eq $app_role_name }
    New-AzureADUserAppRoleAssignment -ObjectId $user.ObjectId -PrincipalId $user.ObjectId -ResourceId $sp.ObjectId -Id $appRole.Id
  }
