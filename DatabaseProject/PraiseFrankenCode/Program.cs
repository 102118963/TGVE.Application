using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PraiseFrankenCode
{
    class Program
    {
        public static string url = "http://localhost:4037/api/";
        public static string key = "Clients/";
        public static string Tours = "Tours/";
        static void Main(string[] args)
        {
            do
            {
                Console.WriteLine("Please enter the corresponding number to your choice\nWould you like to edit 1.Clients or 2.Tours?");
                string keychoice = Console.ReadLine();
                switch (keychoice)
                {
                    case "1":
                        do
                        {
                            MainMenuClients();
                        } while (true);
                        break;
                    case "2":
                        key = Tours;
                        do
                        {
                            MainMenuTours();
                        } while (true);
                        break;
                    default:
                        Console.WriteLine("Please enter something correctly.");
                        break;
                }
            } while (true);

            void MainMenuTours()
            {
                Console.Clear();
                Console.WriteLine("Please enter the corresponding number to your choice\n1.Get Tours\n2.Post Tour\n3.Update Existing Tour\n4.Delete Existing Tour");
                string choice = Console.ReadLine();
                switch (choice)
                {
                    case "1":
                        Console.Clear();
                        Task.Run(TourGetStuff).Wait();
                        break;
                    case "2":
                        Console.Clear();
                        Task.Run(TourPostStuff).Wait();
                        break;

                    case "3":
                        Console.Clear();
                        Task.Run(TourUpdateStuff).Wait();
                        break;
                    case "4":
                        Console.Clear();
                        Task.Run(TourDeleteStuff).Wait();
                        break;

                    default:
                        Console.WriteLine("You entered something wrong, try again.");
                        break;

                }
            }

            void MainMenuClients()
            {
                Console.Clear();
                Console.WriteLine("Please enter the corresponding number to your choice\n1.Get Clients\n2.Post Client\n3.Update Existing Client\n4.Delete Existing Client");
                string choice = Console.ReadLine();
                switch (choice)
                {
                    case "1":
                        Console.Clear();
                        Task.Run(ClientGetStuff).Wait();
                        break;
                    case "2":
                        Console.Clear();
                        Task.Run(ClientPostStuff).Wait();
                        break;

                    case "3":
                        Console.Clear();
                        Task.Run(ClientUpdateStuff).Wait();
                        break;
                    case "4":
                        Console.Clear();
                        Task.Run(ClientDeleteStuff).Wait();
                        break;
                    default:
                        Console.WriteLine("You entered something wrong, try again.");
                        break;

                }
            }
        }
        public static async Task ClientGetStuff()
        {
            Console.WriteLine("Hello There, Getting Stuff...");

            using (HttpClient client = new HttpClient())
            {
                var response = await client.GetAsync(url + key);
                var stringResponse = await response.Content.ReadAsStringAsync();
                var responseObject = JsonConvert.DeserializeObject<List<Client>>(stringResponse);
                for (int i = 0; i < responseObject.Count; i++)
                {
                    Console.WriteLine(responseObject[i].ToString());

                }
                Console.ReadLine();
            }
        }
        public static async Task TourGetStuff()
        {
            Console.WriteLine("Hello There, Getting Stuff...");

            using (HttpClient client = new HttpClient())
            {
                var response = await client.GetAsync(url + Tours);
                var stringResponse = await response.Content.ReadAsStringAsync();
                var responseObject = JsonConvert.DeserializeObject<List<Tour>>(stringResponse);
                for (int i = 0; i < responseObject.Count; i++)
                {
                    Console.WriteLine(responseObject[i].ToString());

                }
                Console.ReadLine();
            }
        }
        public static async Task ClientPostStuff()
        {

            using (HttpClient client = new HttpClient())
            {
                bool looptemp = false;
                DateTime tempDate;
                Console.WriteLine("Please enter your new First Name");
                string tempFName = Console.ReadLine();
                Console.WriteLine("Please enter your new Last Name");
                string tempLName = Console.ReadLine();
                Console.WriteLine("Please enter your new Phone Number");
                string tempPNumber = Console.ReadLine();
                Console.WriteLine("Please enter your new Address");
                string tempAddress = Console.ReadLine();
                do
                {
                    Console.WriteLine("Please enter your Birth Date (DD/MM/YYYY) with a year greater than 1900");
                    tempDate = DateTime.Parse(Console.ReadLine());
                    if (tempDate.Year > 1900)
                    {
                        looptemp = true;
                    }
                } while (looptemp != true);
                Console.WriteLine("Please enter your new Email");
                string tempEmail = Console.ReadLine();
                var dataString = JsonConvert.SerializeObject(new Client
                {
                    FirstName = tempFName,
                    LastName = tempLName,
                    PhoneNumber = tempPNumber,
                    Address = tempAddress,
                    DateOfBirth = tempDate,
                    Email = tempEmail
                },
                    new JsonSerializerSettings
                    {
                        NullValueHandling = NullValueHandling.Ignore,
                        Formatting = Formatting.None,
                        ContractResolver = new CamelCasePropertyNamesContractResolver()
                    });
                var sendData = new StringContent(dataString, System.Text.Encoding.UTF8, "application/json");


                await client.PostAsync(url + key, sendData);
            }

        }
        public static async Task TourPostStuff()
        {

            using (HttpClient client = new HttpClient())
            {
                bool looptemp1 = false;
                bool looptemp2 = false;
                DateTime tempDate1 = new DateTime(1000 / 10 / 10);
                DateTime tempDate2 = new DateTime(1000 / 10 / 10);
                do
                {
                    Console.WriteLine("Please enter the Start Date and Time (DD/MM/YYYY) with a year greater than 1900");
                    try
                    {
                        tempDate1 = DateTime.Parse(Console.ReadLine());
                        if (tempDate1.Year > 1900)
                        {
                            looptemp1 = true;
                        }
                    }
                    catch (Exception e)
                    {
                        e.ToString();
                    }
                } while (looptemp1 != true);
                do
                {
                    Console.WriteLine("Please enter End Date and Time (DD/MM/YYYY) with a year greater than 1900");
                    try
                    {
                        tempDate2 = DateTime.Parse(Console.ReadLine());
                        if (tempDate2.Year > 1900)
                        {
                            looptemp2 = true;
                        }
                    }
                    catch (Exception e)
                    {
                        e.ToString();
                    }
                } while (looptemp2 != true);
                Console.WriteLine("Please enter your new Name");
                string tempName = Console.ReadLine();
                Console.WriteLine("Please enter your new Description");
                string tempDescription = Console.ReadLine();
                Console.WriteLine("Please enter your new Area");
                string tempArea = Console.ReadLine();
                Console.WriteLine("Please enter your new Location");
                string tempLocation = Console.ReadLine();
                var dataString = JsonConvert.SerializeObject(new Tour
                {
                    TourStartTime = tempDate1,
                    TourEndTime = tempDate2,
                    Name = tempName,
                    Description = tempDescription,
                    Area = tempArea,
                    Location = tempLocation
                },
                    new JsonSerializerSettings
                    {
                        NullValueHandling = NullValueHandling.Ignore,
                        Formatting = Formatting.None,
                        ContractResolver = new CamelCasePropertyNamesContractResolver()
                    });
                var sendData = new StringContent(dataString, System.Text.Encoding.UTF8, "application/json");


                await client.PostAsync(url + Tours, sendData);
            }

        }
        public static async Task ClientUpdateStuff()
        {
            using (HttpClient client = new HttpClient())
            {
                var response = await client.GetAsync(url + key);
                var stringResponse = await response.Content.ReadAsStringAsync();
                var responseObject = JsonConvert.DeserializeObject<List<Client>>(stringResponse);
                for (int i = 0; i < responseObject.Count; i++)
                {
                    Console.WriteLine((i + 1) + ":\n" + responseObject[i].ToString());
                }
                Console.WriteLine("Select Client you wish to update");
                int choice = int.Parse(Console.ReadLine());
                if (choice < responseObject.Count + 1 && choice > 0)
                {
                    bool looptemp = false;
                    DateTime tempDate;
                    string chosenId = responseObject[choice - 1].Id;
                    Console.WriteLine("Please enter your new First Name");
                    string tempFName = Console.ReadLine();
                    Console.WriteLine("Please enter your new Last Name");
                    string tempLName = Console.ReadLine();
                    Console.WriteLine("Please enter your new Phone Number");
                    string tempPNumber = Console.ReadLine();
                    Console.WriteLine("Please enter your new Address");
                    string tempAddress = Console.ReadLine();
                    do
                    {
                        Console.WriteLine("Please enter your Birth Date (DD/MM/YYYY) with a year greater than 1900");
                        tempDate = DateTime.Parse(Console.ReadLine());
                        if (tempDate.Year > 1900)
                        {
                            looptemp = true;
                        }
                    } while (looptemp != true);
                    Console.WriteLine("Please enter your new Email");
                    string tempEmail = Console.ReadLine();
                    var dataString = JsonConvert.SerializeObject(new Client
                    {
                        Id = responseObject[choice - 1].Id,
                        FirstName = tempFName,
                        LastName = tempLName,
                        PhoneNumber = tempPNumber,
                        Address = tempAddress,
                        DateOfBirth = tempDate,
                        Email = tempEmail
                    },
                        new JsonSerializerSettings
                        {
                            NullValueHandling = NullValueHandling.Ignore,
                            Formatting = Formatting.None,
                            ContractResolver = new CamelCasePropertyNamesContractResolver()
                        });
                    var sendData = new StringContent(dataString, System.Text.Encoding.UTF8, "application/json");
                    await client.PutAsync(url + key + "/" + chosenId, sendData);
                    
                }
                else
                {
                    Console.WriteLine("You entered something wrong.");
                }


            }
        }
        public static async Task TourUpdateStuff()
        {
            using (HttpClient client = new HttpClient())
            {
                var response = await client.GetAsync(url + key);
                var stringResponse = await response.Content.ReadAsStringAsync();
                var responseObject = JsonConvert.DeserializeObject<List<Tour>>(stringResponse);
                for (int i = 0; i < responseObject.Count; i++)
                {
                    Console.WriteLine((i + 1) + ":\n" + responseObject[i].ToString());
                }
                Console.WriteLine("Select Tour you wish to update");
                int choice = int.Parse(Console.ReadLine());
                if (choice < responseObject.Count + 1 && choice > 0)
                {
                    bool looptemp1 = false;
                    bool looptemp2 = false;
                    DateTime tempDate1 = new DateTime(1000 / 10 / 10);
                    DateTime tempDate2 = new DateTime(1000 / 10 / 10);
                    string chosenId = responseObject[choice - 1].Id;
                    do
                    {
                        Console.WriteLine("Please enter the Start Date and Time (DD/MM/YYYY) with a year greater than 1900");
                        try
                        {
                            tempDate1 = DateTime.Parse(Console.ReadLine());
                            if (tempDate1.Year > 1900)
                            {
                                looptemp1 = true;
                            }
                        }
                        catch (Exception e)
                        {
                            e.ToString();
                        }
                    } while (looptemp1 != true);
                    do
                    {
                        Console.WriteLine("Please enter End Date and Time (DD/MM/YYYY) with a year greater than 1900");
                        try
                        {
                            tempDate2 = DateTime.Parse(Console.ReadLine());
                            if (tempDate2.Year > 1900)
                            {
                                looptemp2 = true;
                            }
                        }
                        catch (Exception e)
                        {
                            e.ToString();
                        }
                    } while (looptemp2 != true);
                    Console.WriteLine("Please enter your new Name");
                    string tempName = Console.ReadLine();
                    Console.WriteLine("Please enter your new Description");
                    string tempDescription = Console.ReadLine();
                    Console.WriteLine("Please enter your new Area");
                    string tempArea = Console.ReadLine();
                    Console.WriteLine("Please enter your new Location");
                    string tempLocation = Console.ReadLine();
                    var dataString = JsonConvert.SerializeObject(new Tour
                    {
                        Id = responseObject[choice - 1].Id,
                        TourStartTime = tempDate1,
                        TourEndTime = tempDate2,
                        Name = tempName,
                        Description = tempDescription,
                        Area = tempArea,
                        Location = tempLocation
                    },
                        new JsonSerializerSettings
                        {
                            NullValueHandling = NullValueHandling.Ignore,
                            Formatting = Formatting.None,
                            ContractResolver = new CamelCasePropertyNamesContractResolver()
                        });
                    var sendData = new StringContent(dataString, System.Text.Encoding.UTF8, "application/json");
                    await client.PutAsync(url + Tours + "/" + chosenId, sendData);
                    
                }
                else
                {
                    Console.WriteLine("You entered something wrong.");
                }


            }
        }
        public static async Task ClientDeleteStuff()
        {

            using (HttpClient client = new HttpClient())
            {
                var response = await client.GetAsync(url + key);
                var stringResponse = await response.Content.ReadAsStringAsync();
                var responseObject = JsonConvert.DeserializeObject<List<Client>>(stringResponse);
                for (int i = 0; i < responseObject.Count; i++)
                {
                    Console.WriteLine((i + 1) + ":\n" + responseObject[i].ToString());
                }
                Console.WriteLine("\n\nSelect task you wish to delete");
                int choice = int.Parse(Console.ReadLine());
                if (choice < responseObject.Count + 1 && choice > 0)
                {
                    string chosenId = responseObject[choice - 1].Id;
                    await client.DeleteAsync(url + key + "/" + chosenId);
                }
                else
                {
                    Console.WriteLine("You entered something wrong.");
                }
            }

        }
        public static async Task TourDeleteStuff()
        {
            using (HttpClient client = new HttpClient())
            {
                var response = await client.GetAsync(url + key);
                var stringResponse = await response.Content.ReadAsStringAsync();
                var responseObject = JsonConvert.DeserializeObject<List<Tour>>(stringResponse);
                for (int i = 0; i < responseObject.Count; i++)
                {
                    Console.WriteLine((i + 1) + ":\n" + responseObject[i].ToString());
                }
                Console.WriteLine("\n\nSelect task you wish to delete");
                int choice = int.Parse(Console.ReadLine());
                if (choice < responseObject.Count + 1 && choice > 0)
                {
                    string chosenId = responseObject[choice - 1].Id;
                    await client.DeleteAsync(url + Tours + "/" + chosenId);
                }
                else
                {
                    Console.WriteLine("You entered something wrong.");
                }
            }
        }
        public class Client
        {
            public string Id { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string PhoneNumber { get; set; }
            public string Address { get; set; }
            public DateTime DateOfBirth { get; set; }
            public string Email { get; set; }

            public override string ToString()
            {
                return "Id: " + Id + "\nFirst Name: " + FirstName
                    + "\nLast Name: " + LastName + "\nPhone Number: " + PhoneNumber
                    + "\nAddress: " + Address + "\nDate of Birth: " + DateOfBirth
                    + "\nEmail: " + Email + "\n";

            }
        }
        public class Tour
        {
            public string Id { get; set; }
            public DateTime TourStartTime { get; set; }
            public DateTime TourEndTime { get; set; }
            public string Name { get; set; }
            public string Description { get; set; }
            public string Area { get; set; }
            public string Location { get; set; }
            public override string ToString()
            {
                return "Id: " + Id
                    + "\nTour Start Time: " + TourStartTime
                    + "\nTour End Time: " + TourEndTime
                    + "\nName: " + Name
                    + "\nDescription: " + Description
                    + "\nArea: " + Area
                    + "\nLocation: " + Location + "\n";

            }
        }
    }
}

