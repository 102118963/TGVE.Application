using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PraiseFrankenCode
{
    class ValidationFailureException : Exception
    {
        public ValidationFailureException()
        {

        }
        public ValidationFailureException(string input):
            base (String.Format("Invalid Input: {0}", input))
        {

        }
    }
}
