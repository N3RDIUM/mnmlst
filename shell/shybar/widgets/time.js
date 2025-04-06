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

export default function Time({ minified }) {
	return (
		<box vertical className={ minified((v) => v ? "TimeWidgetMini" : "TimeWidget") }>
            { minified((v) => !v ? <label className="DateLabel" label={dm(transform)} />  : "") }
			<label className={ minified((v) => v ? "TimeLabelMini" : "TimeLabel") } label={hour(transform)} />
			<label className={ minified((v) => v ? "TimeLabelMini" : "TimeLabel") } label={minute(transform)} />
            { minified((v) => !v ? <label className="DateLabel" label={year(transform)} />  : "") }
		</box>
	);
}
