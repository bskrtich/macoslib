#tag ClassClass CFArrayInherits CFTypeImplements CFPropertyList	#tag Method, Flags = &h0		Function Clone() As CFArray		  #if TargetMacOS		    soft declare function CFArrayCreateCopy Lib CarbonFramework (allocator as Ptr, theArray as Ptr) as Ptr		    		    dim theCopy as CFArray = CFArrayCreateCopy(nil, me)		    return theCopy		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Value(index as Integer) As CFType		  #if TargetMacOS		    soft declare function CFArrayGetCount Lib CarbonFramework (theArray as Ptr) as Integer		    soft declare function CFArrayGetValueAtIndex Lib CarbonFramework (theArray as Ptr, idx as Integer) as Ptr		    		    if index < 0 or index > CFArrayGetCount(me) - 1 then		      raise new OutOfBoundsException		    end if		    		    return CFType.NewObject(CFArrayGetValueAtIndex(me, index))		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor(theList() as CFType)		  #if targetMacOS		    		    soft declare function CFArrayCreate Lib CarbonFramework (allocator as Ptr, values as Ptr, numValues as Integer, callbacks as Ptr) as Ptr		    		    me.Operator_Convert CFArrayCreate(nil, me.GetValuesAsCArray(theList), UBound(theList) + 1, me.defaultCallBacks)		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Function DefaultCallbacks() As Ptr		  dim carbonBundle as CFBundle = CFBundle.NewCFBundle(CarbonBundleID)		  if carbonBundle <> nil then		    const kCFTypeArrayCallBacks = "kCFTypeArrayCallBacks"		    return carbonBundle.DataPointer(kCFTypeArrayCallBacks)		  end if		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Function GetValuesAsCArray(theList() as CFType) As MemoryBlock		  if UBound(theList) = -1 then		    return nil		  end if		  		  const sizeOfPtr = 4		  dim theValues as new MemoryBlock(sizeOfPtr*(1 + UBound(theList)))		  dim offset as Integer = 0		  for index as Integer = 0 to UBound(theList)		    theValues.Ptr(offset) = theList(index)		    offset = offset + sizeOfPtr		  next		  return theValues		End Function	#tag EndMethod	#tag Method, Flags = &h0		 Shared Function ClassID() As UInt32		  #if targetMacOS		    soft declare function CFArrayGetTypeID lib CarbonFramework () as UInt32		    		    static id as Uint32 = CFArrayGetTypeID		    return id		    		  #else		    return 0		  #endif		  		  		End Function	#tag EndMethod	#tag ComputedProperty, Flags = &h0		#tag Getter			Get			#if targetMacOS			dim p as Ptr = me			if p = nil then			return 0			end if						soft declare function CFArrayGetCount lib CarbonFramework (theArray as Ptr) as Integer						return CFArrayGetCount(p)			#endif			End Get		#tag EndGetter		Count As Integer	#tag EndComputedProperty	#tag ViewBehavior		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Count"			Group="Behavior"			InitialValue="0"			Type="Integer"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass