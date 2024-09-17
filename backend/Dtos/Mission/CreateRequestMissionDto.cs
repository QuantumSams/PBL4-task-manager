using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Dtos.Mission
{
    public class CreateRequestMissionDto
    {
        public string name { get; set; } = string.Empty;
        public string description { get; set; } = string.Empty;
        public DateTime createTime { get; set; } = DateTime.Now;
        public DateTime deadTime { get; set; } = DateTime.Now;
        public bool status { get; set; } = false;
    }
}