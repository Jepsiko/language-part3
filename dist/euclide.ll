
@.strP = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @println(i32 %x) #0 {
	%1 = alloca i32, align 4
	store i32 %x, i32* %1, align 4
	%2 = load i32, i32* %1, align 4
	%3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.strP, i32 0, i32 0), i32 %2)
	ret void
}

declare i32 @printf(i8*, ...) #1

declare i32 @getchar()

define i32 @readInt() {
entry:
	%res = alloca i32
	store i32 0, i32* %res

	%isNegative = alloca i1
	%number = alloca i32
	%0 = call i32 @getchar()
	
	%1 = icmp eq i32 %0, 45
	store i1 %1, i1* %isNegative
	br i1 %1, label %loop, label %firstIteration
firstIteration:
	%2 = sub i32 %0, 48
	store i32 %2, i32* %number

	%3 = icmp sge i32 %2, 0
	%4 = icmp sle i32 %2, 9
	%5 = and i1 %3, %4
	br i1 %5, label %continue, label %exit
loop:
	%6 = call i32 @getchar()
	%7 = sub i32 %6, 48
	store i32 %7, i32* %number

	%8 = icmp sge i32 %7, 0
	%9 = icmp sle i32 %7, 9
	%10 = and i1 %8, %9
	br i1 %10, label %continue, label %exit
continue:
	%11 = load i32, i32* %res
	%12 = mul i32 %11, 10
	%13 = load i32, i32* %number
	%14 = add i32 %12, %13 
	store i32 %14, i32* %res

	br label %loop
exit:

	%15 = load i1, i1* %isNegative
	br i1 %15, label %ifNegative, label %endifNegative

ifNegative:
	%16 = load i32, i32* %res
	%17 = mul i32 %16, -1
	store i32 %17, i32* %res

	br label %endifNegative
endifNegative:
	%18 = load i32, i32* %res
	ret i32 %18
}


define i32 @main() {
entry:

%a = alloca i32
%0 = call i32 @readInt()
store i32 %0, i32* %a

%b = alloca i32
%1 = call i32 @readInt()
store i32 %1, i32* %b

br label %whileCond0
whileCond0:
%2 = load i32, i32* %b
%3 = icmp ne i32 %2, 0

br i1 %3, label %whileCode0, label %endwhile0
whileCode0:
%c = alloca i32
%4 = load i32, i32* %b
store i32 %4, i32* %c

br label %whileCond1
whileCond1:
%5 = load i32, i32* %a
%6 = load i32, i32* %b
%7 = icmp sge i32 %5, %6

br i1 %7, label %whileCode1, label %endwhile1
whileCode1:
%8 = load i32, i32* %a
%9 = load i32, i32* %b
%10 = sub i32 %8, %9
store i32 %10, i32* %a

br label %whileCond1
endwhile1:

%11 = load i32, i32* %a
store i32 %11, i32* %b

%12 = load i32, i32* %c
store i32 %12, i32* %a

br label %whileCond0
endwhile0:

%13 = load i32, i32* %a
call void @println(i32 %13)

ret i32 0;
}
