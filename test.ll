define fastcc i64 @"fun129-esc-char"(i64 %"env") nounwind {
%r3713 = tail call fastcc i64 @"fun-make-number"(i64 92)
%r3712 = tail call fastcc i64 @"fun-integer->char"(i64 %r3713)
%r3716 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 1)
%r3715 = tail call fastcc i64 @"fun-integer->char"(i64 %r3716)
%r3719 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 2)
%r3718 = tail call fastcc i64 @"fun-integer->char"(i64 %r3719)
%r3720 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 3)
%r3717 = tail call fastcc i64 @"fun-cons"(i64 %r3718, i64 %r3720)
%r3714 = tail call fastcc i64 @"fun-cons"(i64 %r3715, i64 %r3717)
%r3711 = tail call fastcc i64 @"fun-cons"(i64 %r3712, i64 %r3714)
ret i64 %r3711
}

define fastcc i64 @"fun130-fix-str-format"(i64 %"env") nounwind {
%r3860 = alloca i64
%r3725 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 2)
%r3726 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 3)
%r3724 = tail call fastcc i64 @"fun-="(i64 %r3725, i64 %r3726)
%r3862 = tail call fastcc i64 @"fun-raw-number"(i64 %r3724)
%r3863 = icmp ne i64 %r3862, 0
br i1 %r3863, label %label256, label %label257
label256:
%r3727 = tail call fastcc i64 @"fun-make-null"()
store i64 %r3727, i64* %r3860
br label %label258
label257:
%r3856 = alloca i64
%r3734 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 4, i64 3)
%r3729 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3734)
%r3731 = tail call fastcc i64 @"fun-make-env"(i64 2, i64 %r3729)
%r3732 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3734)
%r3728 = inttoptr i64 %r3732 to i64 (i64)*
%r3741 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 1)
%r3736 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3741)
%r3738 = tail call fastcc i64 @"fun-make-env"(i64 2, i64 %r3736)
%r3739 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3741)
%r3735 = inttoptr i64 %r3739 to i64 (i64)*
%r3742 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 1)
%r3744 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3738, i64 1, i64 %r3742)
%r3743 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 2)
%r3745 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3738, i64 2, i64 %r3743)
%r3737 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3741)
%r3746 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3737, i64 %r3738)
%r3740 = tail call fastcc i64 %r3735(i64 %r3738)
%r3748 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3731, i64 1, i64 %r3740)
%r3747 = tail call fastcc i64 @"fun-make-number"(i64 34)
%r3749 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3731, i64 2, i64 %r3747)
%r3730 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3734)
%r3750 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3730, i64 %r3731)
%r3733 = tail call fastcc i64 %r3728(i64 %r3731)
%r3858 = tail call fastcc i64 @"fun-raw-number"(i64 %r3733)
%r3859 = icmp ne i64 %r3858, 0
br i1 %r3859, label %label259, label %label260
label259:
%r3757 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 2)
%r3752 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3757)
%r3754 = tail call fastcc i64 @"fun-make-env"(i64 3, i64 %r3752)
%r3755 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3757)
%r3751 = inttoptr i64 %r3755 to i64 (i64)*
%r3758 = tail call fastcc i64 @"fun-make-number"(i64 50)
%r3776 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3754, i64 1, i64 %r3758)
%r3759 = tail call fastcc i64 @"fun-make-number"(i64 50)
%r3777 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3754, i64 2, i64 %r3759)
%r3766 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 3)
%r3761 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3766)
%r3763 = tail call fastcc i64 @"fun-make-env"(i64 3, i64 %r3761)
%r3764 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3766)
%r3760 = inttoptr i64 %r3764 to i64 (i64)*
%r3767 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 1)
%r3772 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3763, i64 1, i64 %r3767)
%r3769 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 2)
%r3770 = tail call fastcc i64 @"fun-make-number"(i64 1)
%r3768 = tail call fastcc i64 @"fun-+"(i64 %r3769, i64 %r3770)
%r3773 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3763, i64 2, i64 %r3768)
%r3771 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 3)
%r3774 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3763, i64 3, i64 %r3771)
%r3762 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3766)
%r3775 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3762, i64 %r3763)
%r3765 = tail call fastcc i64 %r3760(i64 %r3763)
%r3778 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3754, i64 3, i64 %r3765)
%r3753 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3757)
%r3779 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3753, i64 %r3754)
%r3756 = tail call fastcc i64 %r3751(i64 %r3754)
store i64 %r3756, i64* %r3856
br label %label261
label260:
%r3852 = alloca i64
%r3786 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 4, i64 3)
%r3781 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3786)
%r3783 = tail call fastcc i64 @"fun-make-env"(i64 2, i64 %r3781)
%r3784 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3786)
%r3780 = inttoptr i64 %r3784 to i64 (i64)*
%r3793 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 1)
%r3788 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3793)
%r3790 = tail call fastcc i64 @"fun-make-env"(i64 2, i64 %r3788)
%r3791 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3793)
%r3787 = inttoptr i64 %r3791 to i64 (i64)*
%r3794 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 1)
%r3796 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3790, i64 1, i64 %r3794)
%r3795 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 2)
%r3797 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3790, i64 2, i64 %r3795)
%r3789 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3793)
%r3798 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3789, i64 %r3790)
%r3792 = tail call fastcc i64 %r3787(i64 %r3790)
%r3800 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3783, i64 1, i64 %r3792)
%r3799 = tail call fastcc i64 @"fun-make-number"(i64 92)
%r3801 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3783, i64 2, i64 %r3799)
%r3782 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3786)
%r3802 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3782, i64 %r3783)
%r3785 = tail call fastcc i64 %r3780(i64 %r3783)
%r3854 = tail call fastcc i64 @"fun-raw-number"(i64 %r3785)
%r3855 = icmp ne i64 %r3854, 0
br i1 %r3855, label %label262, label %label263
label262:
%r3809 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 2)
%r3804 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3809)
%r3806 = tail call fastcc i64 @"fun-make-env"(i64 3, i64 %r3804)
%r3807 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3809)
%r3803 = inttoptr i64 %r3807 to i64 (i64)*
%r3810 = tail call fastcc i64 @"fun-make-number"(i64 53)
%r3828 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3806, i64 1, i64 %r3810)
%r3811 = tail call fastcc i64 @"fun-make-number"(i64 67)
%r3829 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3806, i64 2, i64 %r3811)
%r3818 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 3)
%r3813 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3818)
%r3815 = tail call fastcc i64 @"fun-make-env"(i64 3, i64 %r3813)
%r3816 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3818)
%r3812 = inttoptr i64 %r3816 to i64 (i64)*
%r3819 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 1)
%r3824 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3815, i64 1, i64 %r3819)
%r3821 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 2)
%r3822 = tail call fastcc i64 @"fun-make-number"(i64 1)
%r3820 = tail call fastcc i64 @"fun-+"(i64 %r3821, i64 %r3822)
%r3825 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3815, i64 2, i64 %r3820)
%r3823 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 3)
%r3826 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3815, i64 3, i64 %r3823)
%r3814 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3818)
%r3827 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3814, i64 %r3815)
%r3817 = tail call fastcc i64 %r3812(i64 %r3815)
%r3830 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3806, i64 3, i64 %r3817)
%r3805 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3809)
%r3831 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3805, i64 %r3806)
%r3808 = tail call fastcc i64 %r3803(i64 %r3806)
store i64 %r3808, i64* %r3852
br label %label264
label263:
%r3834 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 1)
%r3835 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 2)
%r3833 = tail call fastcc i64 @"fun-string-ref"(i64 %r3834, i64 %r3835)
%r3842 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 3)
%r3837 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3842)
%r3839 = tail call fastcc i64 @"fun-make-env"(i64 3, i64 %r3837)
%r3840 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3842)
%r3836 = inttoptr i64 %r3840 to i64 (i64)*
%r3843 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 1)
%r3848 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3839, i64 1, i64 %r3843)
%r3845 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 2)
%r3846 = tail call fastcc i64 @"fun-make-number"(i64 1)
%r3844 = tail call fastcc i64 @"fun-+"(i64 %r3845, i64 %r3846)
%r3849 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3839, i64 2, i64 %r3844)
%r3847 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 3)
%r3850 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3839, i64 3, i64 %r3847)
%r3838 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3842)
%r3851 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3838, i64 %r3839)
%r3841 = tail call fastcc i64 %r3836(i64 %r3839)
%r3832 = tail call fastcc i64 @"fun-cons"(i64 %r3833, i64 %r3841)
store i64 %r3832, i64* %r3852
br label %label264
label264:
%r3853 = load i64, i64* %r3852
store i64 %r3853, i64* %r3856
br label %label261
label261:
%r3857 = load i64, i64* %r3856
store i64 %r3857, i64* %r3860
br label %label258
label258:
%r3861 = load i64, i64* %r3860
ret i64 %r3861
}

define fastcc i64 @fun131(i64 %"env") nounwind {
%r3702 = ptrtoint i64 (i64)* @"fun128-str-ref-int" to i64
%r3703 = tail call fastcc i64 @"fun-make-function"(i64 %r3702, i64 %"env", i64 0)
%r3701 = tail call fastcc i64 @"fun-set-variable!"(i64 %"env", i64 0, i64 1, i64 %r3703)
%r3709 = ptrtoint i64 (i64)* @"fun129-esc-char" to i64
%r3710 = tail call fastcc i64 @"fun-make-function"(i64 %r3709, i64 %"env", i64 0)
%r3708 = tail call fastcc i64 @"fun-set-variable!"(i64 %"env", i64 0, i64 2, i64 %r3710)
%r3722 = ptrtoint i64 (i64)* @"fun130-fix-str-format" to i64
%r3723 = tail call fastcc i64 @"fun-make-function"(i64 %r3722, i64 %"env", i64 0)
%r3721 = tail call fastcc i64 @"fun-set-variable!"(i64 %"env", i64 0, i64 3, i64 %r3723)
%r3871 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 0, i64 3)
%r3866 = tail call fastcc i64 @"fun-get-function-env"(i64 %r3871)
%r3868 = tail call fastcc i64 @"fun-make-env"(i64 3, i64 %r3866)
%r3869 = tail call fastcc i64 @"fun-get-function-func"(i64 %r3871)
%r3865 = inttoptr i64 %r3869 to i64 (i64)*
%r3872 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 1)
%r3876 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3868, i64 1, i64 %r3872)
%r3873 = tail call fastcc i64 @"fun-make-number"(i64 0)
%r3877 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3868, i64 2, i64 %r3873)
%r3875 = tail call fastcc i64 @"fun-lookup-variable"(i64 %"env", i64 1, i64 1)
%r3874 = tail call fastcc i64 @"fun-string-length"(i64 %r3875)
%r3878 = tail call fastcc i64 @"fun-vector-set!"(i64 %r3868, i64 3, i64 %r3874)
%r3867 = tail call fastcc i64 @"fun-get-function-nparams"(i64 %r3871)
%r3879 = tail call fastcc i64 @"fun-fix-arbitrary-funcs"(i64 %r3867, i64 %r3868)
%r3870 = tail call fastcc i64 %r3865(i64 %r3868)
%r3864 = tail call fastcc i64 @"fun-list->string"(i64 %r3870)
ret i64 %r3864
}

define fastcc i64 @"fun127-fix-string-format"(i64 %"env") nounwind {
%r3880 = tail call fastcc i64 @"fun-make-env"(i64 3, i64 %"env")
%r3882 = tail call fastcc i64 @fun131(i64 %r3880)
ret i64 %r3882
}

