import { Variable } from "astal";

const hour = Variable(0).poll(
	1000,
	"date +'%H'",
	(out, prev) => parseInt(out),
);
const minute = Variable(0).poll(
	1000,
	"date +'%M'",
	(out, prev) => parseInt(out),
);
const dm = Variable(0).poll(
	1000,
	"date +'%d%m'",
	(out, prev) => parseInt(out),
);
const year = Variable(0).poll(
	1000,
	"date +'%Y'",
	(out, prev) => parseInt(out),
);

const transform = (v) =>
	v.toString().length % 2 == 0 ? v.toString() : "0" + v.toString();

export default function Time() {
	return (
		<box vertical className="TimeWidget">
            <label className="DateLabel" label={dm(transform)} />
			<label className="TimeLabel" label={hour(transform)} />
			<label className="TimeLabel" label={minute(transform)} />
            <label className="DateLabel" label={year(transform)} />
		</box>
	);
}
