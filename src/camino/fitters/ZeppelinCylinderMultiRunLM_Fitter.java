package fitters;

import models.*;
import models.compartments.CompartmentModel;
import optimizers.*;
import inverters.*;
import numerics.*;
import misc.*;
import data.*;
import tools.*;
import imaging.*;

/**
 * <dl>
 * 
 * <dt>Purpose:
 * 
 * <dd>Fits the zeppelincylinder model using multiple runs of a Levenburg
 * Marquardt.
 * 
 * <dt>Description:
 * 
 * <dd> Fitting is as in ZeppelinCylinderLM_Fitter.  The
 * perturbations are 10% of the initial starting value.
 * 
 * </dl>
 *
 * @author  Laura
 * @version $Id$
 *
 */
public class ZeppelinCylinderMultiRunLM_Fitter extends
		ZeppelinCylinderLM_Fitter {

	/**
	 * Constructor implements the mapping between model and optimized
	 * parameters in the Codec object.
	 *
	 * @param scheme The imaging protocol.
	 */
	public ZeppelinCylinderMultiRunLM_Fitter(DW_Scheme scheme,
			int repeats, int seed) {

		this.scheme = scheme;
		makeCodec();
		String[] compNames = new String[2];

		compNames[0] = new String("cylindergpd");
		compNames[1] = new String("zeppelin");

		double[] initialParams = new double[11];
		initialParams[0] = 1.0; //the S0
		initialParams[1] = 0.7; //volume fraction of the first compartment
		initialParams[2] = 0.3; //volume fraction of the second compartment
		initialParams[3] = 1.7E-9;//intra diffusivity
		initialParams[4] = 1.570796326794897;//theta
		initialParams[5] = 0.0;//phi
		initialParams[6] = 2.0E-6;//R
		initialParams[7] = 1.7E-9;//zeppelin diffusivity
		initialParams[8] = 1.570796326794897;//theta_zep
		initialParams[9] = 0.0;//phi_zep
		initialParams[10] = 2.0E-10;//diffperp

		 cm = new CompartmentModel(compNames, initialParams);
		 try {
	            initMultiRunLM_Minimizer(NoiseModel.getNoiseModel(CL_Initializer.noiseModel), new FixedSTD_GaussianPerturbation(), repeats, seed);
		    ((MultiRunLM_Minimizer) minimizer).setCONVERGETHRESH(1e-8);
		    ((MultiRunLM_Minimizer) minimizer).setMAXITER(5000);
	        } catch(Exception e) {
	            throw new LoggedException(e);
	        }

		bcfitter = new BallCylinderMultiRunLM_Fitter(scheme, 1, 0);
		zsfitter = new ZeppelinStickMultiRunLM_Fitter(scheme, 3, 0);

	}



	public static void main(String[] args) {

		CL_Initializer.CL_init(args);
		CL_Initializer.checkParsing(args);
		CL_Initializer.initImagingScheme();
		CL_Initializer.initDataSynthesizer();

		OutputManager om = new OutputManager();

		ZeppelinCylinderMultiRunLM_Fitter inv = new ZeppelinCylinderMultiRunLM_Fitter(
				CL_Initializer.imPars, 100, 0);

		// Loop over the voxels.
		while (CL_Initializer.data.more()) {
			try {

				double[] nextVoxel = CL_Initializer.data.nextVoxel();
				double[][] fit = inv.fit(nextVoxel);

				for (int i = 0; i < fit.length; i++)
					om.output(fit[i]);
			} catch (Exception e) {
				System.err.println(e);
			}
		}

		om.close();
	}

}
