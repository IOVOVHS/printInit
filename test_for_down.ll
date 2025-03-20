; ModuleID = './test_for_down.c'
source_filename = "./test_for_down.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

@.str = private unnamed_addr constant [12 x i8] c"Radius: %f\0A\00", align 1, !dbg !0
@.str.1 = private unnamed_addr constant [14 x i8] c"Diameter: %f\0A\00", align 1, !dbg !7
@.str.2 = private unnamed_addr constant [19 x i8] c"Circumference: %f\0A\00", align 1, !dbg !12
@.str.3 = private unnamed_addr constant [12 x i8] c"Volume: %f\0A\00", align 1, !dbg !17
@.str.4 = private unnamed_addr constant [10 x i8] c"Area: %f\0A\00", align 1, !dbg !19
@.str.5 = private unnamed_addr constant [15 x i8] c"Max value: %d\0A\00", align 1, !dbg !24
@.str.6 = private unnamed_addr constant [18 x i8] c"Sum of array: %d\0A\00", align 1, !dbg !29
@.str.7 = private unnamed_addr constant [18 x i8] c"Final result: %d\0A\00", align 1, !dbg !34
@__const.main.arr = private unnamed_addr constant [5 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5], align 4
@.str.8 = private unnamed_addr constant [15 x i8] c"Total sum: %d\0A\00", align 1, !dbg !36

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @calculateVolumeAndArea(double noundef %0) #0 !dbg !48 {
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  store double %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !53, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.declare(metadata ptr %3, metadata !55, metadata !DIExpression()), !dbg !56
  call void @llvm.dbg.declare(metadata ptr %4, metadata !57, metadata !DIExpression()), !dbg !58
  call void @llvm.dbg.declare(metadata ptr %5, metadata !59, metadata !DIExpression()), !dbg !60
  call void @llvm.dbg.declare(metadata ptr %6, metadata !61, metadata !DIExpression()), !dbg !62
  call void @llvm.dbg.declare(metadata ptr %7, metadata !63, metadata !DIExpression()), !dbg !64
  call void @llvm.dbg.declare(metadata ptr %8, metadata !65, metadata !DIExpression()), !dbg !66
  store double 1.000000e+01, ptr %8, align 8, !dbg !66
  call void @llvm.dbg.declare(metadata ptr %9, metadata !67, metadata !DIExpression()), !dbg !68
  store double 2.000000e+00, ptr %9, align 8, !dbg !68
  store double 3.141590e+00, ptr %3, align 8, !dbg !69
  %10 = load double, ptr %2, align 8, !dbg !70
  %11 = load double, ptr %9, align 8, !dbg !71
  %12 = fmul double %10, %11, !dbg !72
  store double %12, ptr %6, align 8, !dbg !73
  %13 = load double, ptr %3, align 8, !dbg !74
  %14 = load double, ptr %6, align 8, !dbg !75
  %15 = fmul double %13, %14, !dbg !76
  store double %15, ptr %7, align 8, !dbg !77
  %16 = load double, ptr %3, align 8, !dbg !78
  %17 = fmul double 0x3FF5555555555555, %16, !dbg !79
  %18 = load double, ptr %2, align 8, !dbg !80
  %19 = fmul double %17, %18, !dbg !81
  %20 = load double, ptr %2, align 8, !dbg !82
  %21 = fmul double %19, %20, !dbg !83
  %22 = load double, ptr %2, align 8, !dbg !84
  %23 = fmul double %21, %22, !dbg !85
  store double %23, ptr %4, align 8, !dbg !86
  %24 = load double, ptr %3, align 8, !dbg !87
  %25 = fmul double 4.000000e+00, %24, !dbg !88
  %26 = load double, ptr %2, align 8, !dbg !89
  %27 = fmul double %25, %26, !dbg !90
  %28 = load double, ptr %2, align 8, !dbg !91
  %29 = fmul double %27, %28, !dbg !92
  store double %29, ptr %5, align 8, !dbg !93
  %30 = load double, ptr %2, align 8, !dbg !94
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %30), !dbg !95
  %32 = load double, ptr %6, align 8, !dbg !96
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %32), !dbg !97
  %34 = load double, ptr %7, align 8, !dbg !98
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %34), !dbg !99
  %36 = load double, ptr %4, align 8, !dbg !100
  %37 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, double noundef %36), !dbg !101
  %38 = load double, ptr %5, align 8, !dbg !102
  %39 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, double noundef %38), !dbg !103
  ret void, !dbg !104
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(ptr noundef, ...) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @findMax(ptr noundef %0, i32 noundef %1) #0 !dbg !105 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !110, metadata !DIExpression()), !dbg !111
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !112, metadata !DIExpression()), !dbg !113
  call void @llvm.dbg.declare(metadata ptr %5, metadata !114, metadata !DIExpression()), !dbg !115
  call void @llvm.dbg.declare(metadata ptr %6, metadata !116, metadata !DIExpression()), !dbg !117
  store i32 0, ptr %6, align 4, !dbg !117
  call void @llvm.dbg.declare(metadata ptr %7, metadata !118, metadata !DIExpression()), !dbg !119
  store i32 0, ptr %7, align 4, !dbg !119
  call void @llvm.dbg.declare(metadata ptr %8, metadata !120, metadata !DIExpression()), !dbg !121
  store i32 10, ptr %8, align 4, !dbg !121
  store i32 0, ptr %6, align 4, !dbg !122
  br label %9, !dbg !124

9:                                                ; preds = %21, %2
  %10 = load i32, ptr %6, align 4, !dbg !125
  %11 = load i32, ptr %4, align 4, !dbg !127
  %12 = icmp slt i32 %10, %11, !dbg !128
  br i1 %12, label %13, label %24, !dbg !129

13:                                               ; preds = %9
  %14 = load ptr, ptr %3, align 8, !dbg !130
  %15 = load i32, ptr %6, align 4, !dbg !132
  %16 = sext i32 %15 to i64, !dbg !130
  %17 = getelementptr inbounds i32, ptr %14, i64 %16, !dbg !130
  %18 = load i32, ptr %17, align 4, !dbg !130
  %19 = load i32, ptr %7, align 4, !dbg !133
  %20 = add nsw i32 %19, %18, !dbg !133
  store i32 %20, ptr %7, align 4, !dbg !133
  br label %21, !dbg !134

21:                                               ; preds = %13
  %22 = load i32, ptr %6, align 4, !dbg !135
  %23 = add nsw i32 %22, 1, !dbg !135
  store i32 %23, ptr %6, align 4, !dbg !135
  br label %9, !dbg !136, !llvm.loop !137

24:                                               ; preds = %9
  %25 = load i32, ptr %4, align 4, !dbg !140
  %26 = icmp sgt i32 %25, 0, !dbg !142
  br i1 %26, label %27, label %31, !dbg !143

27:                                               ; preds = %24
  %28 = load ptr, ptr %3, align 8, !dbg !144
  %29 = getelementptr inbounds i32, ptr %28, i64 0, !dbg !144
  %30 = load i32, ptr %29, align 4, !dbg !144
  store i32 %30, ptr %5, align 4, !dbg !146
  br label %31, !dbg !147

31:                                               ; preds = %27, %24
  store i32 1, ptr %6, align 4, !dbg !148
  br label %32, !dbg !150

32:                                               ; preds = %51, %31
  %33 = load i32, ptr %6, align 4, !dbg !151
  %34 = load i32, ptr %4, align 4, !dbg !153
  %35 = icmp slt i32 %33, %34, !dbg !154
  br i1 %35, label %36, label %54, !dbg !155

36:                                               ; preds = %32
  %37 = load ptr, ptr %3, align 8, !dbg !156
  %38 = load i32, ptr %6, align 4, !dbg !159
  %39 = sext i32 %38 to i64, !dbg !156
  %40 = getelementptr inbounds i32, ptr %37, i64 %39, !dbg !156
  %41 = load i32, ptr %40, align 4, !dbg !156
  %42 = load i32, ptr %5, align 4, !dbg !160
  %43 = icmp sgt i32 %41, %42, !dbg !161
  br i1 %43, label %44, label %50, !dbg !162

44:                                               ; preds = %36
  %45 = load ptr, ptr %3, align 8, !dbg !163
  %46 = load i32, ptr %6, align 4, !dbg !165
  %47 = sext i32 %46 to i64, !dbg !163
  %48 = getelementptr inbounds i32, ptr %45, i64 %47, !dbg !163
  %49 = load i32, ptr %48, align 4, !dbg !163
  store i32 %49, ptr %5, align 4, !dbg !166
  br label %50, !dbg !167

50:                                               ; preds = %44, %36
  br label %51, !dbg !168

51:                                               ; preds = %50
  %52 = load i32, ptr %6, align 4, !dbg !169
  %53 = add nsw i32 %52, 1, !dbg !169
  store i32 %53, ptr %6, align 4, !dbg !169
  br label %32, !dbg !170, !llvm.loop !171

54:                                               ; preds = %32
  %55 = load i32, ptr %5, align 4, !dbg !173
  %56 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %55), !dbg !174
  %57 = load i32, ptr %7, align 4, !dbg !175
  %58 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %57), !dbg !176
  %59 = load i32, ptr %5, align 4, !dbg !177
  ret i32 %59, !dbg !178
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @complexCalculation(i32 noundef %0, i32 noundef %1) #0 !dbg !179 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  call void @llvm.dbg.declare(metadata ptr %3, metadata !182, metadata !DIExpression()), !dbg !183
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !184, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.declare(metadata ptr %5, metadata !186, metadata !DIExpression()), !dbg !187
  call void @llvm.dbg.declare(metadata ptr %6, metadata !188, metadata !DIExpression()), !dbg !189
  call void @llvm.dbg.declare(metadata ptr %7, metadata !190, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.declare(metadata ptr %8, metadata !192, metadata !DIExpression()), !dbg !193
  store i32 0, ptr %8, align 4, !dbg !193
  call void @llvm.dbg.declare(metadata ptr %9, metadata !194, metadata !DIExpression()), !dbg !195
  store i32 3, ptr %9, align 4, !dbg !195
  %10 = load i32, ptr %3, align 4, !dbg !196
  %11 = load i32, ptr %4, align 4, !dbg !197
  %12 = mul nsw i32 %10, %11, !dbg !198
  store i32 %12, ptr %6, align 4, !dbg !199
  %13 = load i32, ptr %3, align 4, !dbg !200
  %14 = load i32, ptr %4, align 4, !dbg !201
  %15 = add nsw i32 %13, %14, !dbg !202
  store i32 %15, ptr %7, align 4, !dbg !203
  %16 = load i32, ptr %6, align 4, !dbg !204
  %17 = load i32, ptr %7, align 4, !dbg !206
  %18 = icmp sgt i32 %16, %17, !dbg !207
  br i1 %18, label %19, label %23, !dbg !208

19:                                               ; preds = %2
  %20 = load i32, ptr %6, align 4, !dbg !209
  %21 = load i32, ptr %9, align 4, !dbg !211
  %22 = mul nsw i32 %20, %21, !dbg !212
  store i32 %22, ptr %5, align 4, !dbg !213
  br label %27, !dbg !214

23:                                               ; preds = %2
  %24 = load i32, ptr %7, align 4, !dbg !215
  %25 = load i32, ptr %9, align 4, !dbg !217
  %26 = sub nsw i32 %24, %25, !dbg !218
  store i32 %26, ptr %5, align 4, !dbg !219
  br label %27

27:                                               ; preds = %23, %19
  %28 = load i32, ptr %5, align 4, !dbg !220
  %29 = load i32, ptr %9, align 4, !dbg !221
  %30 = mul nsw i32 %28, %29, !dbg !222
  store i32 %30, ptr %8, align 4, !dbg !223
  %31 = load i32, ptr %8, align 4, !dbg !224
  %32 = call i32 (ptr, ...) @printf(ptr noundef @.str.7, i32 noundef %31), !dbg !225
  ret void, !dbg !226
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @calculateSum(i32 noundef %0) #0 !dbg !227 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !230, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.declare(metadata ptr %3, metadata !232, metadata !DIExpression()), !dbg !233
  store i32 0, ptr %3, align 4, !dbg !233
  call void @llvm.dbg.declare(metadata ptr %4, metadata !234, metadata !DIExpression()), !dbg !235
  call void @llvm.dbg.declare(metadata ptr %5, metadata !236, metadata !DIExpression()), !dbg !237
  call void @llvm.dbg.declare(metadata ptr %6, metadata !238, metadata !DIExpression()), !dbg !239
  store i32 5, ptr %6, align 4, !dbg !239
  store i32 1, ptr %4, align 4, !dbg !240
  br label %7, !dbg !242

7:                                                ; preds = %15, %1
  %8 = load i32, ptr %4, align 4, !dbg !243
  %9 = load i32, ptr %2, align 4, !dbg !245
  %10 = icmp sle i32 %8, %9, !dbg !246
  br i1 %10, label %11, label %18, !dbg !247

11:                                               ; preds = %7
  %12 = load i32, ptr %4, align 4, !dbg !248
  %13 = load i32, ptr %3, align 4, !dbg !250
  %14 = add nsw i32 %13, %12, !dbg !250
  store i32 %14, ptr %3, align 4, !dbg !250
  br label %15, !dbg !251

15:                                               ; preds = %11
  %16 = load i32, ptr %4, align 4, !dbg !252
  %17 = add nsw i32 %16, 1, !dbg !252
  store i32 %17, ptr %4, align 4, !dbg !252
  br label %7, !dbg !253, !llvm.loop !254

18:                                               ; preds = %7
  %19 = load i32, ptr %3, align 4, !dbg !256
  %20 = load i32, ptr %6, align 4, !dbg !257
  %21 = add nsw i32 %19, %20, !dbg !258
  store i32 %21, ptr %5, align 4, !dbg !259
  %22 = load i32, ptr %5, align 4, !dbg !260
  ret i32 %22, !dbg !261
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 !dbg !262 {
  %1 = alloca i32, align 4
  %2 = alloca double, align 8
  %3 = alloca [5 x i32], align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !265, metadata !DIExpression()), !dbg !266
  store double 5.000000e+00, ptr %2, align 8, !dbg !266
  %5 = load double, ptr %2, align 8, !dbg !267
  call void @calculateVolumeAndArea(double noundef %5), !dbg !268
  call void @llvm.dbg.declare(metadata ptr %3, metadata !269, metadata !DIExpression()), !dbg !273
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %3, ptr align 4 @__const.main.arr, i64 20, i1 false), !dbg !273
  %6 = getelementptr inbounds [5 x i32], ptr %3, i64 0, i64 0, !dbg !274
  %7 = call i32 @findMax(ptr noundef %6, i32 noundef 5), !dbg !275
  call void @complexCalculation(i32 noundef 7, i32 noundef 10), !dbg !276
  call void @llvm.dbg.declare(metadata ptr %4, metadata !277, metadata !DIExpression()), !dbg !278
  %8 = call i32 @calculateSum(i32 noundef 10), !dbg !279
  store i32 %8, ptr %4, align 4, !dbg !278
  %9 = load i32, ptr %4, align 4, !dbg !280
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, i32 noundef %9), !dbg !281
  ret i32 0, !dbg !282
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #3

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+complxnum,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+jsconv,+lse,+neon,+pauth,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+complxnum,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+jsconv,+lse,+neon,+pauth,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.dbg.cu = !{!38}
!llvm.module.flags = !{!41, !42, !43, !44, !45, !46}
!llvm.ident = !{!47}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 17, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "./test_for_down.c", directory: "/Users/lain/codeFiles/llvm-pass/printInit")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 12)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !2, line: 18, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !10)
!10 = !{!11}
!11 = !DISubrange(count: 14)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(scope: null, file: !2, line: 19, type: !14, isLocal: true, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 152, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 19)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(scope: null, file: !2, line: 20, type: !3, isLocal: true, isDefinition: true)
!19 = !DIGlobalVariableExpression(var: !20, expr: !DIExpression())
!20 = distinct !DIGlobalVariable(scope: null, file: !2, line: 21, type: !21, isLocal: true, isDefinition: true)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !22)
!22 = !{!23}
!23 = !DISubrange(count: 10)
!24 = !DIGlobalVariableExpression(var: !25, expr: !DIExpression())
!25 = distinct !DIGlobalVariable(scope: null, file: !2, line: 44, type: !26, isLocal: true, isDefinition: true)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 120, elements: !27)
!27 = !{!28}
!28 = !DISubrange(count: 15)
!29 = !DIGlobalVariableExpression(var: !30, expr: !DIExpression())
!30 = distinct !DIGlobalVariable(scope: null, file: !2, line: 45, type: !31, isLocal: true, isDefinition: true)
!31 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 144, elements: !32)
!32 = !{!33}
!33 = !DISubrange(count: 18)
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(scope: null, file: !2, line: 67, type: !31, isLocal: true, isDefinition: true)
!36 = !DIGlobalVariableExpression(var: !37, expr: !DIExpression())
!37 = distinct !DIGlobalVariable(scope: null, file: !2, line: 95, type: !26, isLocal: true, isDefinition: true)
!38 = distinct !DICompileUnit(language: DW_LANG_C11, file: !39, producer: "Homebrew clang version 18.1.8", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !40, splitDebugInlining: false, nameTableKind: Apple, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk", sdk: "MacOSX14.sdk")
!39 = !DIFile(filename: "test_for_down.c", directory: "/Users/lain/codeFiles/llvm-pass/printInit")
!40 = !{!0, !7, !12, !17, !19, !24, !29, !34, !36}
!41 = !{i32 7, !"Dwarf Version", i32 4}
!42 = !{i32 2, !"Debug Info Version", i32 3}
!43 = !{i32 1, !"wchar_size", i32 4}
!44 = !{i32 8, !"PIC Level", i32 2}
!45 = !{i32 7, !"uwtable", i32 1}
!46 = !{i32 7, !"frame-pointer", i32 1}
!47 = !{!"Homebrew clang version 18.1.8"}
!48 = distinct !DISubprogram(name: "calculateVolumeAndArea", scope: !2, file: !2, line: 3, type: !49, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !38, retainedNodes: !52)
!49 = !DISubroutineType(types: !50)
!50 = !{null, !51}
!51 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!52 = !{}
!53 = !DILocalVariable(name: "radius", arg: 1, scope: !48, file: !2, line: 3, type: !51)
!54 = !DILocation(line: 3, column: 36, scope: !48)
!55 = !DILocalVariable(name: "pi", scope: !48, file: !2, line: 4, type: !51)
!56 = !DILocation(line: 4, column: 12, scope: !48)
!57 = !DILocalVariable(name: "volume", scope: !48, file: !2, line: 5, type: !51)
!58 = !DILocation(line: 5, column: 12, scope: !48)
!59 = !DILocalVariable(name: "area", scope: !48, file: !2, line: 5, type: !51)
!60 = !DILocation(line: 5, column: 20, scope: !48)
!61 = !DILocalVariable(name: "diameter", scope: !48, file: !2, line: 6, type: !51)
!62 = !DILocation(line: 6, column: 12, scope: !48)
!63 = !DILocalVariable(name: "circumference", scope: !48, file: !2, line: 6, type: !51)
!64 = !DILocation(line: 6, column: 22, scope: !48)
!65 = !DILocalVariable(name: "height", scope: !48, file: !2, line: 7, type: !51)
!66 = !DILocation(line: 7, column: 12, scope: !48)
!67 = !DILocalVariable(name: "factor", scope: !48, file: !2, line: 8, type: !51)
!68 = !DILocation(line: 8, column: 12, scope: !48)
!69 = !DILocation(line: 10, column: 8, scope: !48)
!70 = !DILocation(line: 12, column: 16, scope: !48)
!71 = !DILocation(line: 12, column: 25, scope: !48)
!72 = !DILocation(line: 12, column: 23, scope: !48)
!73 = !DILocation(line: 12, column: 14, scope: !48)
!74 = !DILocation(line: 13, column: 21, scope: !48)
!75 = !DILocation(line: 13, column: 26, scope: !48)
!76 = !DILocation(line: 13, column: 24, scope: !48)
!77 = !DILocation(line: 13, column: 19, scope: !48)
!78 = !DILocation(line: 14, column: 28, scope: !48)
!79 = !DILocation(line: 14, column: 26, scope: !48)
!80 = !DILocation(line: 14, column: 33, scope: !48)
!81 = !DILocation(line: 14, column: 31, scope: !48)
!82 = !DILocation(line: 14, column: 42, scope: !48)
!83 = !DILocation(line: 14, column: 40, scope: !48)
!84 = !DILocation(line: 14, column: 51, scope: !48)
!85 = !DILocation(line: 14, column: 49, scope: !48)
!86 = !DILocation(line: 14, column: 12, scope: !48)
!87 = !DILocation(line: 15, column: 18, scope: !48)
!88 = !DILocation(line: 15, column: 16, scope: !48)
!89 = !DILocation(line: 15, column: 23, scope: !48)
!90 = !DILocation(line: 15, column: 21, scope: !48)
!91 = !DILocation(line: 15, column: 32, scope: !48)
!92 = !DILocation(line: 15, column: 30, scope: !48)
!93 = !DILocation(line: 15, column: 10, scope: !48)
!94 = !DILocation(line: 17, column: 28, scope: !48)
!95 = !DILocation(line: 17, column: 5, scope: !48)
!96 = !DILocation(line: 18, column: 30, scope: !48)
!97 = !DILocation(line: 18, column: 5, scope: !48)
!98 = !DILocation(line: 19, column: 35, scope: !48)
!99 = !DILocation(line: 19, column: 5, scope: !48)
!100 = !DILocation(line: 20, column: 28, scope: !48)
!101 = !DILocation(line: 20, column: 5, scope: !48)
!102 = !DILocation(line: 21, column: 26, scope: !48)
!103 = !DILocation(line: 21, column: 5, scope: !48)
!104 = !DILocation(line: 22, column: 1, scope: !48)
!105 = distinct !DISubprogram(name: "findMax", scope: !2, file: !2, line: 24, type: !106, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !38, retainedNodes: !52)
!106 = !DISubroutineType(types: !107)
!107 = !{!108, !109, !108}
!108 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!110 = !DILocalVariable(name: "arr", arg: 1, scope: !105, file: !2, line: 24, type: !109)
!111 = !DILocation(line: 24, column: 17, scope: !105)
!112 = !DILocalVariable(name: "size", arg: 2, scope: !105, file: !2, line: 24, type: !108)
!113 = !DILocation(line: 24, column: 28, scope: !105)
!114 = !DILocalVariable(name: "max", scope: !105, file: !2, line: 25, type: !108)
!115 = !DILocation(line: 25, column: 9, scope: !105)
!116 = !DILocalVariable(name: "i", scope: !105, file: !2, line: 26, type: !108)
!117 = !DILocation(line: 26, column: 9, scope: !105)
!118 = !DILocalVariable(name: "sum", scope: !105, file: !2, line: 27, type: !108)
!119 = !DILocation(line: 27, column: 9, scope: !105)
!120 = !DILocalVariable(name: "j", scope: !105, file: !2, line: 28, type: !108)
!121 = !DILocation(line: 28, column: 9, scope: !105)
!122 = !DILocation(line: 30, column: 12, scope: !123)
!123 = distinct !DILexicalBlock(scope: !105, file: !2, line: 30, column: 5)
!124 = !DILocation(line: 30, column: 10, scope: !123)
!125 = !DILocation(line: 30, column: 17, scope: !126)
!126 = distinct !DILexicalBlock(scope: !123, file: !2, line: 30, column: 5)
!127 = !DILocation(line: 30, column: 21, scope: !126)
!128 = !DILocation(line: 30, column: 19, scope: !126)
!129 = !DILocation(line: 30, column: 5, scope: !123)
!130 = !DILocation(line: 31, column: 16, scope: !131)
!131 = distinct !DILexicalBlock(scope: !126, file: !2, line: 30, column: 32)
!132 = !DILocation(line: 31, column: 20, scope: !131)
!133 = !DILocation(line: 31, column: 13, scope: !131)
!134 = !DILocation(line: 32, column: 5, scope: !131)
!135 = !DILocation(line: 30, column: 28, scope: !126)
!136 = !DILocation(line: 30, column: 5, scope: !126)
!137 = distinct !{!137, !129, !138, !139}
!138 = !DILocation(line: 32, column: 5, scope: !123)
!139 = !{!"llvm.loop.mustprogress"}
!140 = !DILocation(line: 34, column: 9, scope: !141)
!141 = distinct !DILexicalBlock(scope: !105, file: !2, line: 34, column: 9)
!142 = !DILocation(line: 34, column: 14, scope: !141)
!143 = !DILocation(line: 34, column: 9, scope: !105)
!144 = !DILocation(line: 35, column: 15, scope: !145)
!145 = distinct !DILexicalBlock(scope: !141, file: !2, line: 34, column: 19)
!146 = !DILocation(line: 35, column: 13, scope: !145)
!147 = !DILocation(line: 36, column: 5, scope: !145)
!148 = !DILocation(line: 38, column: 12, scope: !149)
!149 = distinct !DILexicalBlock(scope: !105, file: !2, line: 38, column: 5)
!150 = !DILocation(line: 38, column: 10, scope: !149)
!151 = !DILocation(line: 38, column: 17, scope: !152)
!152 = distinct !DILexicalBlock(scope: !149, file: !2, line: 38, column: 5)
!153 = !DILocation(line: 38, column: 21, scope: !152)
!154 = !DILocation(line: 38, column: 19, scope: !152)
!155 = !DILocation(line: 38, column: 5, scope: !149)
!156 = !DILocation(line: 39, column: 13, scope: !157)
!157 = distinct !DILexicalBlock(scope: !158, file: !2, line: 39, column: 13)
!158 = distinct !DILexicalBlock(scope: !152, file: !2, line: 38, column: 32)
!159 = !DILocation(line: 39, column: 17, scope: !157)
!160 = !DILocation(line: 39, column: 22, scope: !157)
!161 = !DILocation(line: 39, column: 20, scope: !157)
!162 = !DILocation(line: 39, column: 13, scope: !158)
!163 = !DILocation(line: 40, column: 19, scope: !164)
!164 = distinct !DILexicalBlock(scope: !157, file: !2, line: 39, column: 27)
!165 = !DILocation(line: 40, column: 23, scope: !164)
!166 = !DILocation(line: 40, column: 17, scope: !164)
!167 = !DILocation(line: 41, column: 9, scope: !164)
!168 = !DILocation(line: 42, column: 5, scope: !158)
!169 = !DILocation(line: 38, column: 28, scope: !152)
!170 = !DILocation(line: 38, column: 5, scope: !152)
!171 = distinct !{!171, !155, !172, !139}
!172 = !DILocation(line: 42, column: 5, scope: !149)
!173 = !DILocation(line: 44, column: 31, scope: !105)
!174 = !DILocation(line: 44, column: 5, scope: !105)
!175 = !DILocation(line: 45, column: 34, scope: !105)
!176 = !DILocation(line: 45, column: 5, scope: !105)
!177 = !DILocation(line: 47, column: 12, scope: !105)
!178 = !DILocation(line: 47, column: 5, scope: !105)
!179 = distinct !DISubprogram(name: "complexCalculation", scope: !2, file: !2, line: 50, type: !180, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !38, retainedNodes: !52)
!180 = !DISubroutineType(types: !181)
!181 = !{null, !108, !108}
!182 = !DILocalVariable(name: "a", arg: 1, scope: !179, file: !2, line: 50, type: !108)
!183 = !DILocation(line: 50, column: 29, scope: !179)
!184 = !DILocalVariable(name: "b", arg: 2, scope: !179, file: !2, line: 50, type: !108)
!185 = !DILocation(line: 50, column: 36, scope: !179)
!186 = !DILocalVariable(name: "result", scope: !179, file: !2, line: 51, type: !108)
!187 = !DILocation(line: 51, column: 9, scope: !179)
!188 = !DILocalVariable(name: "temp1", scope: !179, file: !2, line: 52, type: !108)
!189 = !DILocation(line: 52, column: 9, scope: !179)
!190 = !DILocalVariable(name: "temp2", scope: !179, file: !2, line: 52, type: !108)
!191 = !DILocation(line: 52, column: 16, scope: !179)
!192 = !DILocalVariable(name: "finalResult", scope: !179, file: !2, line: 53, type: !108)
!193 = !DILocation(line: 53, column: 9, scope: !179)
!194 = !DILocalVariable(name: "factor", scope: !179, file: !2, line: 54, type: !108)
!195 = !DILocation(line: 54, column: 9, scope: !179)
!196 = !DILocation(line: 56, column: 13, scope: !179)
!197 = !DILocation(line: 56, column: 17, scope: !179)
!198 = !DILocation(line: 56, column: 15, scope: !179)
!199 = !DILocation(line: 56, column: 11, scope: !179)
!200 = !DILocation(line: 57, column: 13, scope: !179)
!201 = !DILocation(line: 57, column: 17, scope: !179)
!202 = !DILocation(line: 57, column: 15, scope: !179)
!203 = !DILocation(line: 57, column: 11, scope: !179)
!204 = !DILocation(line: 59, column: 9, scope: !205)
!205 = distinct !DILexicalBlock(scope: !179, file: !2, line: 59, column: 9)
!206 = !DILocation(line: 59, column: 17, scope: !205)
!207 = !DILocation(line: 59, column: 15, scope: !205)
!208 = !DILocation(line: 59, column: 9, scope: !179)
!209 = !DILocation(line: 60, column: 18, scope: !210)
!210 = distinct !DILexicalBlock(scope: !205, file: !2, line: 59, column: 24)
!211 = !DILocation(line: 60, column: 26, scope: !210)
!212 = !DILocation(line: 60, column: 24, scope: !210)
!213 = !DILocation(line: 60, column: 16, scope: !210)
!214 = !DILocation(line: 61, column: 5, scope: !210)
!215 = !DILocation(line: 62, column: 18, scope: !216)
!216 = distinct !DILexicalBlock(scope: !205, file: !2, line: 61, column: 12)
!217 = !DILocation(line: 62, column: 26, scope: !216)
!218 = !DILocation(line: 62, column: 24, scope: !216)
!219 = !DILocation(line: 62, column: 16, scope: !216)
!220 = !DILocation(line: 65, column: 19, scope: !179)
!221 = !DILocation(line: 65, column: 28, scope: !179)
!222 = !DILocation(line: 65, column: 26, scope: !179)
!223 = !DILocation(line: 65, column: 17, scope: !179)
!224 = !DILocation(line: 67, column: 34, scope: !179)
!225 = !DILocation(line: 67, column: 5, scope: !179)
!226 = !DILocation(line: 68, column: 1, scope: !179)
!227 = distinct !DISubprogram(name: "calculateSum", scope: !2, file: !2, line: 70, type: !228, scopeLine: 70, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !38, retainedNodes: !52)
!228 = !DISubroutineType(types: !229)
!229 = !{!108, !108}
!230 = !DILocalVariable(name: "n", arg: 1, scope: !227, file: !2, line: 70, type: !108)
!231 = !DILocation(line: 70, column: 22, scope: !227)
!232 = !DILocalVariable(name: "sum", scope: !227, file: !2, line: 71, type: !108)
!233 = !DILocation(line: 71, column: 9, scope: !227)
!234 = !DILocalVariable(name: "i", scope: !227, file: !2, line: 72, type: !108)
!235 = !DILocation(line: 72, column: 9, scope: !227)
!236 = !DILocalVariable(name: "result", scope: !227, file: !2, line: 73, type: !108)
!237 = !DILocation(line: 73, column: 9, scope: !227)
!238 = !DILocalVariable(name: "j", scope: !227, file: !2, line: 74, type: !108)
!239 = !DILocation(line: 74, column: 9, scope: !227)
!240 = !DILocation(line: 76, column: 12, scope: !241)
!241 = distinct !DILexicalBlock(scope: !227, file: !2, line: 76, column: 5)
!242 = !DILocation(line: 76, column: 10, scope: !241)
!243 = !DILocation(line: 76, column: 17, scope: !244)
!244 = distinct !DILexicalBlock(scope: !241, file: !2, line: 76, column: 5)
!245 = !DILocation(line: 76, column: 22, scope: !244)
!246 = !DILocation(line: 76, column: 19, scope: !244)
!247 = !DILocation(line: 76, column: 5, scope: !241)
!248 = !DILocation(line: 77, column: 16, scope: !249)
!249 = distinct !DILexicalBlock(scope: !244, file: !2, line: 76, column: 30)
!250 = !DILocation(line: 77, column: 13, scope: !249)
!251 = !DILocation(line: 78, column: 5, scope: !249)
!252 = !DILocation(line: 76, column: 26, scope: !244)
!253 = !DILocation(line: 76, column: 5, scope: !244)
!254 = distinct !{!254, !247, !255, !139}
!255 = !DILocation(line: 78, column: 5, scope: !241)
!256 = !DILocation(line: 80, column: 14, scope: !227)
!257 = !DILocation(line: 80, column: 20, scope: !227)
!258 = !DILocation(line: 80, column: 18, scope: !227)
!259 = !DILocation(line: 80, column: 12, scope: !227)
!260 = !DILocation(line: 82, column: 12, scope: !227)
!261 = !DILocation(line: 82, column: 5, scope: !227)
!262 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 85, type: !263, scopeLine: 85, spFlags: DISPFlagDefinition, unit: !38, retainedNodes: !52)
!263 = !DISubroutineType(types: !264)
!264 = !{!108}
!265 = !DILocalVariable(name: "radius", scope: !262, file: !2, line: 86, type: !51)
!266 = !DILocation(line: 86, column: 12, scope: !262)
!267 = !DILocation(line: 87, column: 28, scope: !262)
!268 = !DILocation(line: 87, column: 5, scope: !262)
!269 = !DILocalVariable(name: "arr", scope: !262, file: !2, line: 89, type: !270)
!270 = !DICompositeType(tag: DW_TAG_array_type, baseType: !108, size: 160, elements: !271)
!271 = !{!272}
!272 = !DISubrange(count: 5)
!273 = !DILocation(line: 89, column: 9, scope: !262)
!274 = !DILocation(line: 90, column: 13, scope: !262)
!275 = !DILocation(line: 90, column: 5, scope: !262)
!276 = !DILocation(line: 92, column: 5, scope: !262)
!277 = !DILocalVariable(name: "total", scope: !262, file: !2, line: 94, type: !108)
!278 = !DILocation(line: 94, column: 9, scope: !262)
!279 = !DILocation(line: 94, column: 17, scope: !262)
!280 = !DILocation(line: 95, column: 31, scope: !262)
!281 = !DILocation(line: 95, column: 5, scope: !262)
!282 = !DILocation(line: 97, column: 5, scope: !262)
