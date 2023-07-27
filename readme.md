# Local Judge

A small but complete judge system written in BAT & VBS within 100 lines of code.

Support AC, RE, TLE & WA.

## Usage

Place your test points to `problems\xxxxx`, then simply run:

```
judge xxxxx your_executable_path_here
```

## Details

```
Usage: judge <problem_number> <executable_path> [time_limit]
Return:
	0 Accepted
	1 Wrong Answer
	2 Runtime Error
	3 Time Limit Exceeded
	4 Missing Output File(s)
```

