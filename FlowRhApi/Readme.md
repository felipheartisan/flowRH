# Iniciando projeto

`dotnet new webapi --use-controllers -o FlowRhApi`

# Dependencias

`dotnet add package Microsoft.AspNetCore.OpenApi --version 8.0.0`

`dotnet add package MySql.EntityFrameworkCore --version 8.0.0`

`dotnet add package Microsoft.EntityFrameworkCore.Design --version 8.0.0`

`dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design --version 8.0.0`

`dotnet add package Microsoft.EntityFrameworkCore.Tools --version 8.0.0`

`dotnet add package Microsoft.EntityFrameworkCore.SqlServer --version 8.0.0`

`dotnet add package Microsoft.OpenApi`

`dotnet add package Swashbuckle.AspNetCore` 

`dotnet tool install --global dotnet-ef`

# Subindo as migrations

`dotnet ef migrations add CreateTables --context AppDbContext`

`dotnet ef database update`