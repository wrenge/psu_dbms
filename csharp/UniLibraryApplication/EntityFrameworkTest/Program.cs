// See https://aka.ms/new-console-template for more information

using EntityFrameworkTest;

Console.WriteLine("Hello, World!");
using (var db = new UniLibraryContext())
{
    var authors = db.Authors;
    Console.WriteLine("Список объектов:");
    foreach (var author in authors)
    {
        Console.WriteLine($"{author.AuthorId}.{author.AuthorName} - {author.AuthorSurname}");
    }
}