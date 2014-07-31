# parallel.sh: execute jobs in parallel
#
# Copyright (C) 2012 Andrew Martin.
#
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Author(s): Andrew Martin <sublimino@gmail.com>
#
#
# --iterations  处理的任务总数
# --workers     同时并行的最大任务总数
#
#
#
#
#
ITERATIONS=50
WORKERS=5

USAGE="$0 [--iterations num] [--workers num] COMMAND"

while [ $# -gt 0 ]; do
    case "$1" in
    (--iterations) ITERATIONS=$2; shift;;
    (--workers) WORKERS=$2; shift;;
    (--help) echo $USAGE; exit 0;;
    (--) shift; break;;
    (*)  break;;
    esac
    shift
done

WORKER_COMMAND=${@-"sleep 2"} #如果没有参数输入，默认返回"sleep 2"

MAX_WORKERS_FILE=$(mktemp -t parallel.workers.XXXXX) || exit 1
echo $WORKERS > $MAX_WORKERS_FILE #最大并行的处理个数

echo "Starting $ITERATIONS iterations of '$WORKER_COMMAND' with $WORKERS parallel workers."
echo "Workers can be altered at runtime by editing $MAX_WORKERS_FILE"
echo "Press any key to continue..."
read -n 1 c

for ((i=1; i<=$ITERATIONS; i++)); do
    while (true); do
        MAX_WORKERS=$(cat $MAX_WORKERS_FILE)
        WORKERS=$(jobs -r | wc -l) #检查并行运行的任务总数
        echo -e "\e[91mWorkers: $WORKERS / $MAX_WORKERS\e[39m"
        [[ $WORKERS -lt $MAX_WORKERS ]] && break || sleep 1
    done
    echo "$i: $WORKER_COMMAND"
    eval "$WORKER_COMMAND &"
done

unlink $MAX_WORKERS_FILE
echo -e "Completed $((i-1)) iterations of '$WORKER_COMMAND'"
exit 0

