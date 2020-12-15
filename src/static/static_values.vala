using Gee;
using LiveChart;

namespace LiveChart.Static {
        
    [Version (experimental=true)]
    public struct NamedValue {
        public string name;
        public double value;
    }
    
    [Version (experimental=true)]
    public class StaticValues : LinkedList<NamedValue?> {

        public Bounds bounds {
            get; construct set;
        }
 
        public StaticValues() {
            this.bounds = new Bounds();
        }

        public new void add(NamedValue value) {
            bounds.update(value.value);
            base.add(value);
        }
    }
}