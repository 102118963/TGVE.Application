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
                Console.WriteLine("Please enter the corresponding number to your choice\n1.Get Tours\n");
                string choice = Console.ReadLine();
                switch (choice)
                {
                    case "1":
                        Console.Clear();
                        Task.Run(TourGetStuff).Wait();
                        break;

                    
                    default:
                        Console.WriteLine("You entered something wrong, try again.");
                        break;

                }
            }

            void MainMenuClients()
            {
                Console.Clear();
                Console.WriteLine("Please enter the corresponding number to your choice\n1.Get Clients");
                string choice = Console.ReadLine();
                switch (choice)
                {
                    case "1":
                        Console.Clear();
                        Task.Run(ClientGetStuff).Wait();
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

